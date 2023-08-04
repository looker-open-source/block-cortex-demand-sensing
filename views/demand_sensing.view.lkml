view: demand_sensing {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: (WITH
  CalDate AS (
  SELECT
    date,
    EXTRACT (week
    FROM
      date) AS week
  FROM
    UNNEST(GENERATE_DATE_ARRAY(DATE_ADD(current_date(), INTERVAL -cast(@{years_of_past_data} as INT64) YEAR), DATE_ADD(current_date(), INTERVAL 13 WEEK))) AS date ),
  Grid AS (
  SELECT
    DISTINCT SalesOrders.MaterialNumber_MATNR AS Product,
    SalesOrders.ShipToPartyItem_KUNNR AS Customer,
    SalesOrders.ShipToPartyItemName_KUNNR AS CustomerName,
    SalesOrders.RequestedDeliveryDate_VDATU AS Date,
    Customers.City_ORT01 AS Location,
    Customers.PostalCode_PSTLZ AS PostalCode
  FROM
    `@{GCP_PROJECT}.@{REPORTING_DATASET}.SalesOrders` SalesOrders
  LEFT JOIN
    `@{GCP_PROJECT}.@{REPORTING_DATASET}.CustomersMD` Customers
  ON
    SalesOrders.Client_MANDT=Customers.Client_MANDT
    AND SalesOrders.ShipToPartyItem_KUNNR=Customers.CustomerNumber_KUNNR
  WHERE
    SalesOrders.Client_MANDT = "@{CLIENT}"
  UNION DISTINCT
  SELECT
    DemandForecast.CatalogItemID AS Product,
    DemandForecast.CustomerId AS Customer,
    CustomersMD.Name1_NAME1 AS CustomerName,
    DemandForecast.StartDateOfWeek AS Date,
    CustomersMD.City_ORT01 AS Location,
    CustomersMD.PostalCode_PSTLZ AS PostalCode
  FROM
    `@{GCP_PROJECT}.@{REPORTING_DATASET}.DemandForecast`DemandForecast
    INNER JOIN `@{GCP_PROJECT}.@{REPORTING_DATASET}.CustomersMD` CustomersMD
  ON CustomersMD.CustomerNumber_KUNNR=DemandForecast.CustomerId
and CustomersMD.Client_MANDT= "@{CLIENT}" ),
  Sales AS (
  SELECT
    SalesOrders.Client_MANDT AS Client_MANDT,
    SalesOrders.MaterialNumber_MATNR AS Product,
    SalesOrders.RequestedDeliveryDate_VDATU AS Date,
    SalesOrders.ShipToPartyItem_KUNNR AS Customer,
    SalesOrders.ShipToPartyItemName_KUNNR AS CustomerName,
    SalesOrders.CumulativeOrderQuantity_KWMENG AS SalesOrderQuantity,
    Customers.City_ORT01 AS Location,
    Customers.CountryKey_LAND1 AS Country,
    Customers.PostalCode_PSTLZ AS PostalCode,
    SUM(SalesOrders.CumulativeOrderQuantity_KWMENG) OVER(PARTITION BY SalesOrders.MaterialNumber_MATNR ORDER BY SalesOrders.RequestedDeliveryDate_VDATU ASC ROWS 13 PRECEDING) AS Past13WeekSales,
    SUM(SalesOrders.CumulativeOrderQuantity_KWMENG) OVER(PARTITION BY SalesOrders.MaterialNumber_MATNR ORDER BY SalesOrders.RequestedDeliveryDate_VDATU ASC ROWS 52 PRECEDING) AS Past52WeekSales,
  FROM
    `@{GCP_PROJECT}.@{REPORTING_DATASET}.SalesOrders` SalesOrders
  LEFT JOIN
    `@{GCP_PROJECT}.@{REPORTING_DATASET}.CustomersMD` Customers
  ON
    SalesOrders.Client_MANDT=Customers.Client_MANDT
    AND SalesOrders.ShipToPartyItem_KUNNR=Customers.CustomerNumber_KUNNR
  WHERE
    SalesOrders.Client_MANDT= "@{CLIENT}" ),
  Forecast AS (
  SELECT
    DemandForecast.CatalogItemID AS Product,
    DemandForecast.StartDateOfWeek AS Date,
    DemandForecast.CustomerId AS Customer,
    DemandForecast.ForecastQuantity AS Sales,
    CustomersMD.City_ORT01 AS Location,
    DemandForecast.ForecastQuantityLowerBound,
    DemandForecast.ForecastQuantityUpperBound
  FROM
    `@{GCP_PROJECT}.@{REPORTING_DATASET}.DemandForecast` DemandForecast
    INNER JOIN `@{GCP_PROJECT}.@{REPORTING_DATASET}.CustomersMD` CustomersMD
  ON CustomersMD.CustomerNumber_KUNNR=DemandForecast.CustomerId
and CustomersMD.Client_MANDT= "@{CLIENT}"),

  DemandPlan AS (
  SELECT
    DemandPlan.MaterialNumber AS Product,
    DemandPlan.WeekStart AS Date,
    DemandPlan.CustomerId AS Customer,
    DemandPlan.DemandPlan AS Sales,
    CustomersMd.City_ORT01 AS Location,
  FROM
    `@{GCP_PROJECT}.@{REPORTING_DATASET}.DemandPlan` DemandPlan

INNER JOIN `@{GCP_PROJECT}.@{REPORTING_DATASET}.CustomersMD` CustomersMD

ON CustomersMD.CustomerNumber_KUNNR=DemandPlan.CustomerId
and CustomersMD.Client_MANDT= "@{CLIENT}" ),

  Weather AS(
SELECT
Weather.MaxTemp,
Weather.MinTemp,
Weather.Country,
Weather.PostCode,
Weather.Date,
Weather.AvgMaxTemp,
Weather.AvgMinTemp,
IF
    (COUNT(CASE
          WHEN (MaxTemp>AvgMaxTemp) THEN 1
      END
        ) OVER (PARTITION BY EXTRACT(year FROM Weather.Date),
        EXTRACT(week
        FROM
          Weather.Date),
        Weather.PostCode)>=2,
      TRUE,
      FALSE) AS HeatWave,
  IF
    (COUNT(CASE
          WHEN (MinTemp<AvgMinTemp) THEN 1
      END
        ) OVER (PARTITION BY EXTRACT(year FROM Weather.Date),
        EXTRACT(week
        FROM
          Weather.Date),
        Weather.PostCode)>=2,
      TRUE,
      FALSE) AS ColdFront
From
(SELECT
  MaxTemp  MaxTemp,
  MinTemp  MinTemp,
  Country Country,
  PostCode PostCode,
  date Date,
  AVG(MaxTemp) OVER(PARTITION BY postcode, extract (week from date) order by extract (week from date) RANGE BETWEEN 20 PRECEDING AND CURRENT ROW) AvgMaxTemp,
  AVG(MinTemp) OVER(PARTITION BY postcode, extract (week from date) order by extract (week from date) RANGE BETWEEN 20 PRECEDING AND CURRENT ROW) AvgMinTemp,
FROM
   @{GCP_PROJECT}.@{K9_REPORTING_DATASET}.WeatherDaily) As Weather),
  Trends AS(
  SELECT
  WeekStart,
  Week,
  InterestOverTime,
  Country,
  HierarchyId,
  SearchTerm,
  HistoricalMin,
  HistoricalMax,
  ((InterestOverTime-HistoricalMin)/(HistoricalMax-HistoricalMin))*100 AS NormalizedScore,
  AVG(((InterestOverTime-HistoricalMin)/(HistoricalMax-HistoricalMin))*100) OVER (PARTITION BY Country, HierarchyId )AS AvgNormalizedScore,
  AVG(((InterestOverTime-HistoricalMin)/(HistoricalMax-HistoricalMin))*100) OVER (PARTITION BY Country, HierarchyId ORDER BY Trends.Week RANGE BETWEEN 44 PRECEDING AND CURRENT ROW )AS AvgNormalizedScoreFor10Months,
FROM (
  SELECT
    WeekStart,
    Extract( WEEK from WeekStart) as Week,
    InterestOverTime,
    CountryCode as Country,
    HierarchyId,
    HierarchyText as SearchTerm,
    MIN(InterestOverTime) OVER (PARTITION BY CountryCode, HierarchyId, EXTRACT(WEEK FROM CAST(WeekStart AS date)) ) AS HistoricalMin,
    MAX(InterestOverTime) OVER (PARTITION BY CountryCode, HierarchyId, EXTRACT(WEEK FROM CAST(WeekStart AS date)) ) AS HistoricalMax
  FROM
    `@{GCP_PROJECT}.@{K9_REPORTING_DATASET}.Trends`)Trends
WHERE
  HistoricalMin != HistoricalMax ),
  Materials as (Select
    MaterialsMD.MaterialText_MAKTX,
    MaterialsMD.MaterialNumber_MATNR,
    MaterialsMD.Client_MANDT,
    ProductHierarchyText.Description_vtext as HierarchyText
    from
    `@{GCP_PROJECT}.@{REPORTING_DATASET}.MaterialsMD` MaterialsMD
    left JOIN
(SELECT
    distinct Hierarchy_Prodh,Client_MANDT,Description_vtext,Level_STUFE,Language_SPRAS
  FROM
   `@{GCP_PROJECT}.@{REPORTING_DATASET}.ProductHierarchiesMD`) ProductHierarchyText
  ON left(MaterialsMD.ProductHierarchy_Prdha, 6 ) = ProductHierarchyText.Hierarchy_Prodh
    AND MaterialsMD.Client_MANDT = ProductHierarchyText.Client_MANDT
    AND ProductHierarchyText.Level_STUFE='3'
    AND ProductHierarchyText.Language_SPRAS='E'
  )
SELECT
  CalDate.Date,
  CalDate.Week,
  Grid.Product,
  Sales.Client_MANDT,
  materials.MaterialText_MAKTX AS ProductName,
  Grid.CustomerName AS Customer,
  Grid.Location,
  Sales.Country,
  Sales.SalesOrderQuantity AS Sales,
  Sales.Past13WeekSales,
  Sales.Past52WeekSales,
  DemandPlan.Sales DemandPlan,
  ROUND(Forecast.Sales,1) ForecastQuantity,
  ROUND(Forecast.ForecastQuantityLowerBound, 1) AS ForecastQuantityLowerBound,
  ROUND(Forecast.ForecastQuantityUpperBound, 1) AS ForecastQuantityUpperBound,
  Trends.SearchTerm,
  Trends.InterestOverTime,
  ROUND(Weather.MaxTemp,1) AS AverageHighTemperature,
  ROUND(Weather.MinTemp,1) AS AverageLowTemperature,
  ROUND((Weather.MaxTemp+Weather.MinTemp)/2,1) AverageTemperature,
  ROUND(AVG((Weather.MaxTemp+Weather.MinTemp)/2) OVER (PARTITION BY Grid.Location, Grid.Product ORDER BY CalDate.Date ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING ),1) AS MovingAverageTemperature,
  PromotionCalendar.DiscountPercent,
  PromotionCalendar.IsPromo,
  IF(HolidayCalendar.HolidayDate IS NULL,0,1) AS IsHoliday,
  ---ForecastOutsideStatisticalRange Impact Score
IF
  ((DemandPlan.Sales > Forecast.ForecastQuantityUpperBound)
    OR (DemandPlan.Sales < Forecast.ForecastQuantityLowerBound),
    ROUND((ABS(Forecast.Sales-DemandPlan.Sales)/DemandPlan.Sales)*100,2),
    0) AS ForecastOutsideStatisticalRangeImpactScore,
---HeatWave Impact Score
IF(HeatWave IS TRUE,
    IF(CorrValue>0.0
    AND (LAG(DemandPlan.sales,1,0)OVER(PARTITION BY Sales.product, Sales.location, EXTRACT(week FROM CalDate.date)
      ORDER BY EXTRACT(week FROM CalDate.date)ASC))>Forecast.ForecastQuantityUpperBound-0.05*Forecast.ForecastQuantityUpperBound,
    ROUND((ABS(Forecast.Sales-DemandPlan.Sales)/DemandPlan.Sales)*100,2),
    IF(CorrValue<0.0
    And (LAG(DemandPlan.sales,1,0)OVER(PARTITION BY EXTRACT(week FROM CalDate.date)
      ORDER BY EXTRACT(week FROM CalDate.date)ASC))<Forecast.ForecastQuantityLowerBound+0.05*Forecast.ForecastQuantityLowerBound,
    ROUND((ABS(Forecast.Sales-DemandPlan.Sales)/DemandPlan.Sales)*100,2),0)),0) AS HeatWaveImpactScore,

---ColdFront Impact Score
IF(ColdFront IS TRUE,
    IF(CorrValue<0.0
    AND (LAG(DemandPlan.sales,1,0)OVER(PARTITION BY Sales.product, Sales.location, EXTRACT(week FROM CalDate.date)
      ORDER BY EXTRACT(week FROM CalDate.date)ASC))>Forecast.ForecastQuantityUpperBound-0.05*Forecast.ForecastQuantityUpperBound,
    ROUND((ABS(Forecast.Sales-DemandPlan.Sales)/DemandPlan.Sales)*100,2),
    IF(CorrValue>0.0
    And (LAG(DemandPlan.sales,1,0)OVER(PARTITION BY EXTRACT(week FROM CalDate.date)
      ORDER BY EXTRACT(week FROM CalDate.date)ASC))<Forecast.ForecastQuantityLowerBound+0.05*Forecast.ForecastQuantityLowerBound,
    ROUND((ABS(Forecast.Sales-DemandPlan.Sales)/DemandPlan.Sales)*100,2),0)),0) AS ColdFrontImpactScore,

  --- PromoDiffrential Impact Score
IF
  ( PromotionCalendar.IsPromo=true
    AND (DemandPlan.Sales>Forecast.ForecastQuantityUpperBound
      OR DemandPlan.Sales<Forecast.ForecastQuantityLowerBound),
    ROUND((ABS(Forecast.Sales-DemandPlan.Sales)/DemandPlan.Sales)*100,2),
    0) AS PromoDiffrentialImpactScore,
  ---NonSeasonalTrends Impact Score
IF
  ((DemandPlan.Sales>Forecast.ForecastQuantityUpperBound
      OR DemandPlan.Sales<Forecast.ForecastQuantityLowerBound)
    AND Trends.Week BETWEEN Trends.Week
    AND Trends.Week+3
    AND ((ABS(NormalizedScore-AvgNormalizedScoreFor10Months)/ AvgNormalizedScoreFor10Months)*100 > 0.25),
    ROUND((ABS(Forecast.Sales-DemandPlan.Sales)/DemandPlan.Sales)*100,2),
    0) AS NonSeasonalTrendsImpactScore,

FROM
  CalDate
LEFT JOIN
  Grid
ON
  CalDate.date = Grid.date
LEFT JOIN
  Sales
ON
  CalDate.date = Sales.date
  AND Grid.product = Sales.product
  AND Grid.customer = Sales.customer
  AND Grid.location = Sales.location
LEFT JOIN
  Forecast
ON
  CalDate.date = Forecast.date
  AND Grid.product = Forecast.product
  AND Grid.customer = Forecast.customer
  AND Grid.location = Forecast.location
LEFT JOIN
  DemandPlan
ON
  CalDate.date = DemandPlan.date
  AND Grid.product = DemandPlan.product
  AND Grid.customer = DemandPlan.customer
  AND Grid.location = DemandPlan.location
LEFT JOIN
  Weather
ON
  Grid.PostalCode=Weather.PostCode
  AND CalDate.Date=Weather.Date
LEFT JOIN
  ${correlation_table_pdt.SQL_TABLE_NAME} AS CorrelationTable
ON
  Grid.Location=CorrelationTable.Location
  AND Grid.Product=CorrelationTable.product
LEFT JOIN
  Materials
ON
  Grid.product =Materials.MaterialNumber_MATNR
  AND Materials.Client_MANDT= "@{CLIENT}"
  --AND Sales.Client_MANDT=Materials.Client_MANDT
LEFT JOIN
  Trends
ON
  CalDate.date=Trends.WeekStart
  AND Materials.HierarchyText = Trends.SearchTerm
  AND Sales.Country=Trends.Country
LEFT JOIN
  `@{GCP_PROJECT}.@{REPORTING_DATASET}.PromotionCalendar` PromotionCalendar
ON
  CalDate.date=PromotionCalendar.StartDateOfWeek
  AND Grid.product=PromotionCalendar.CatalogItemId
  AND Grid.customer=PromotionCalendar.Customerid
LEFT JOIN
  `@{GCP_PROJECT}.@{K9_REPORTING_DATASET}.HolidayCalendar` HolidayCalendar
ON
  Grid.Date = HolidayCalendar.HolidayDate)
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Average Temperature" in Explore.

  dimension: client_mandt {
    type: number
    sql: ${TABLE}.Client_MANDT ;;
  }
  dimension: average_temperature {
    type: number
    sql: ${TABLE}.AverageTemperature ;;
  }
  dimension: moving_average {
    type: number
    sql:Case
        When CAST(${TABLE}.Date AS DATE) <= CAST (Current_date() AS DATE)
        THEN ${TABLE}.MovingAverageTemperature
        End;;
  }
  measure: temperature {
    type: average
    sql:
      CASE
        WHEN CAST(${TABLE}.Date AS DATE) <= CAST (Current_date() AS DATE)
        THEN ${average_temperature}
        ELSE NULL
      END ;;
  }

  measure: forecast_temperature {
    type: average
    sql:
      CASE
        WHEN CAST(${TABLE}.Date AS DATE) > CAST (Current_date() AS DATE)
        THEN ${average_temperature}
        ELSE NULL
      END ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_average_temperature {
    type: sum
    sql: ${average_temperature} ;;
  }

  measure: average_average_temperature {
    type: average
    sql: ${average_temperature} ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.Customer ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension: forecast_quantity_lower_bound {
    type: number
    sql: ${TABLE}.ForecastQuantityLowerBound ;;
  }

  dimension: forecast_quantity_upper_bound {
    type: number
    sql: ${TABLE}.ForecastQuantityUpperBound ;;
  }

  dimension: high_temperature {
    type: number
    sql: ${TABLE}.HighTemperature ;;
  }

  dimension: interest_over_time {
    type: number
    sql: if(${TABLE}.InterestOverTime is null,0,${TABLE}.InterestOverTime) ;;
  }

  dimension: is_holiday {
    type: number
    sql: ${TABLE}.IsHoliday ;;
  }

  dimension: is_promo {
    type: number
    sql: if(${TABLE}.InterestOverTime is null,0,${TABLE}.InterestOverTime) ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.Location ;;
  }

  dimension: low_temperature {
    type: number
    sql: ${TABLE}.LowTemperature ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.Product ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.ProductName ;;
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.RecordType ;;
  }

  dimension: demand_plan {
    type: number
    sql:
    CASE
      WHEN CAST(${TABLE}.Date AS DATE) > CAST (Current_date() AS DATE)
      THEN ${TABLE}.DemandPlan
    ELSE
      NULL
    END;;
  }

  dimension: demand_plan_past {
    type: number
    sql:${TABLE}.DemandPlan;;
  }

  dimension: forecast_quantity {
    type: number
    sql:${TABLE}.ForecastQuantity
      ;;
  }

  dimension: order_quantity {
    type: number
    sql:${TABLE}.Sales;;
  }

  measure: thirteen_week_sale{
    type: sum
    sql:
    CASE
      WHEN CAST(${TABLE}.Date AS DATE) <= CAST (Current_date() AS DATE) and DATE_DIFF(CAST (Current_date() AS DATE), Cast(${TABLE}.Date as Date), Day)<=91
      THEN ${TABLE}.Sales
    ELSE
      NULL
    END;;
  }

  measure: fifty_two_week_sale{
    type: sum
    sql:
    CASE
      WHEN ${TABLE}.RecordType='SalesOrders' and CAST(${TABLE}.Date AS DATE) <= CAST (Current_date() AS DATE) and DATE_DIFF(CAST (Current_date() AS DATE), Cast(${TABLE}.Date as Date), Day)<=366
      THEN ${TABLE}.Sales
    ELSE
      NULL
    END;;
  }

  measure: wholesale_quantity_measure {
    type: average
    sql:
     CASE
      WHEN CAST(${TABLE}.Date AS DATE) <= CAST (Current_date() AS DATE)
      THEN round(${order_quantity})
     ELSE
      NULL
    END;;
  }

  measure: forecast {
    type: average
    sql:
    CASE
      WHEN CAST(${TABLE}.Date AS DATE) > CAST (Current_date() AS DATE)
      THEN round(${forecast_quantity})
    ELSE
      NULL
    END;;
  }

  measure: forecast_lower {
    type: average
    sql:
    CASE
     WHEN CAST(${TABLE}.Date AS DATE) > CAST (Current_date() AS DATE)
     THEN round(${forecast_quantity_lower_bound})
    ELSE
     NULL
    END;;
  }
  measure: forecast_upper {
    type: average
    sql:
    CASE
     WHEN CAST(${TABLE}.Date AS DATE) > CAST (Current_date() AS DATE)
     THEN round(${forecast_quantity_upper_bound})
    ELSE
     NULL
    END;;
  }

  measure: thirteen_week_forecast{
    type: sum
    sql:
      CASE
        WHEN CAST(${TABLE}.Date AS DATE) > CAST (Current_date() AS DATE) and DATE_DIFF(Cast(${TABLE}.Date as Date), CAST (Current_date() AS DATE), Day)<=91
        THEN ${forecast_quantity}
      END ;;
    value_format_name: decimal_0
  }

  measure: thirteen_week_sales_volume{
    type: average
    sql:${thirteen_week_past_sales_volume} ;;
    value_format_name: decimal_0
  }

  measure: fifty_two_week_sales_volume{
    type: average
    sql:${fifty_two_past_sales_volume} ;;
    value_format_name: decimal_0
  }

  dimension: thirteen_week_past_sales_volume{
    type: number
    sql:${TABLE}.Past13WeekSales;;
  }

  dimension: fifty_two_past_sales_volume {
    type: number
    sql:${TABLE}.Past52WeekSales;;
  }


  dimension: discount_percent {
    type: number
    sql: ${TABLE}.DiscountPercent ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.Sales ;;
  }

  dimension: search_term {
    type: string
    sql: ${TABLE}.SearchTerm ;;
  }

  measure: count {
    type: count
    drill_fields: [product_name]
  }
}
