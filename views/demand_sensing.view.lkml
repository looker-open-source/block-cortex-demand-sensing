# The name of this view in Looker is "Di Demand Shaping"

view: demand_sensing {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `@{DATASET}.DemandSensing`;;
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
        When CAST(${TABLE}.Date AS DATE) <= CAST ('2022-02-28' AS DATE)
        THEN ${TABLE}.MovingAverageTemperature
        End;;
  }
  measure: temperature {
    type: average
    sql:
      CASE
        WHEN CAST(${TABLE}.Date AS DATE) <= CAST ('2022-02-28' AS DATE)
        THEN ${average_temperature}
        ELSE NULL
      END ;;
  }

  measure: forecast_temperature {
    type: average
    sql:
      CASE
        WHEN CAST(${TABLE}.Date AS DATE) > CAST ('2022-02-28' AS DATE)
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
    sql: ${TABLE}.IsPromo ;;
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
      WHEN CAST(${TABLE}.Date AS DATE) > CAST ('2022-02-28' AS DATE)
      THEN ${TABLE}.DemandPlan
    ELSE
      NULL
    END;;
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
      WHEN CAST(${TABLE}.Date AS DATE) <= CAST ('2022-02-28' AS DATE) and DATE_DIFF(CAST ('2022-02-28' AS DATE), Cast(${TABLE}.Date as Date), Day)<=91
      THEN ${TABLE}.Sales
    ELSE
      NULL
    END;;
  }

  measure: fifty_two_week_sale{
    type: sum
    sql:
    CASE
      WHEN ${TABLE}.RecordType='SalesOrders' and CAST(${TABLE}.Date AS DATE) <= CAST ('2022-02-28' AS DATE) and DATE_DIFF(CAST ('2022-02-28' AS DATE), Cast(${TABLE}.Date as Date), Day)<=366
      THEN ${TABLE}.Sales
    ELSE
      NULL
    END;;
  }

  measure: past_sales_quantity {
    type: average
    sql:
    CASE
      WHEN CAST(${TABLE}.Date AS DATE) <= CAST ('2022-02-28' AS DATE)
      THEN ${TABLE}.RetailUnitSold
    ELSE
      NULL
    END;;
  }

  measure: wholesale_quantity_measure {
    type: average
    sql:
     CASE
      WHEN CAST(${TABLE}.Date AS DATE) <= CAST ('2022-02-28' AS DATE)
      THEN round(${order_quantity})
     ELSE
      NULL
    END;;
  }

  measure: forecast {
    type: average
    sql:
    CASE
      WHEN CAST(${TABLE}.Date AS DATE) > CAST ('2022-02-28' AS DATE)
      THEN round(${forecast_quantity})
    ELSE
      NULL
    END;;
  }

  measure: forecast_lower {
    type: average
    sql:
    CASE
     WHEN CAST(${TABLE}.Date AS DATE) > CAST ('2022-02-28' AS DATE)
     THEN round(${forecast_quantity_lower_bound})
    ELSE
     NULL
    END;;
  }
  measure: forecast_upper {
    type: average
    sql:
    CASE
     WHEN CAST(${TABLE}.Date AS DATE) > CAST ('2022-02-28' AS DATE)
     THEN round(${forecast_quantity_upper_bound})
    ELSE
     NULL
    END;;
  }

  measure: thirteen_week_forecast{
    type: sum
    sql:
      CASE
        WHEN CAST(${TABLE}.Date AS DATE) > CAST ('2022-02-28' AS DATE) and DATE_DIFF(Cast(${TABLE}.Date as Date), CAST ('2022-02-28' AS DATE), Day)<=91
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

  dimension: retail_price {
    type: number
    sql: ${TABLE}.RetailPrice ;;
  }

  measure: retail_price_per_unit {
    type: average
    sql:  ${retail_price}*(1-${discount_percent}/100);;
    value_format_name: decimal_2
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

  dimension: impact_score {
    type: number
    sql: IF
        (${TABLE}.PromoDiffrentialImpactScore>${TABLE}.HeatWaveImpactScore,
        IF
          (${TABLE}.PromoDiffrentialImpactScore>${TABLE}.ColdFront,
          IF
            (${TABLE}.PromoDiffrentialImpactScore>${TABLE}.NonSeasonalTrendsImpactScore,
            IF
              (${TABLE}.PromoDiffrentialImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                ${TABLE}.PromoDiffrentialImpactScore,
                ${TABLE}.ForecastOutsideStatisticalRangeImpactScore),
            IF
              (${TABLE}.NonSeasonalTrendsImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                ${TABLE}.NonSeasonalTrendsImpactScore,
                ${TABLE}.ForecastOutsideStatisticalRangeImpactScore) ),
          IF
            (${TABLE}.ColdFront>${TABLE}.NonSeasonalTrendsImpactScore,
            IF
              (${TABLE}.ColdFront>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                ${TABLE}.ColdFront,
                ${TABLE}.ForecastOutsideStatisticalRangeImpactScore),
            IF
              (${TABLE}.NonSeasonalTrendsImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                ${TABLE}.NonSeasonalTrendsImpactScore,
                ${TABLE}.ForecastOutsideStatisticalRangeImpactScore)) ),
        IF
          (${TABLE}.HeatWaveImpactScore>${TABLE}.ColdFront,
          IF
            (${TABLE}.HeatWaveImpactScore>${TABLE}.NonSeasonalTrendsImpactScore,
            IF
              (${TABLE}.HeatWaveImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                ${TABLE}.HeatWaveImpactScore,
                ${TABLE}.ForecastOutsideStatisticalRangeImpactScore),
            IF
              (${TABLE}.NonSeasonalTrendsImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                ${TABLE}.NonSeasonalTrendsImpactScore,
                ${TABLE}.ForecastOutsideStatisticalRangeImpactScore) ),
          IF
            (${TABLE}.ColdFront>${TABLE}.NonSeasonalTrendsImpactScore,
            IF
              (${TABLE}.ColdFront>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                ${TABLE}.ColdFront,
                ${TABLE}.ForecastOutsideStatisticalRangeImpactScore),
            IF
              (${TABLE}.NonSeasonalTrendsImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                ${TABLE}.NonSeasonalTrendsImpactScore,
                ${TABLE}.ForecastOutsideStatisticalRangeImpactScore)) ) ) ;;
  }

  dimension: alert_dashboard_link {
    type: string
    sql: IF
        (${TABLE}.PromoDiffrentialImpactScore>${TABLE}.HeatWaveImpactScore,
        IF
          (${TABLE}.PromoDiffrentialImpactScore>${TABLE}.ColdFront,
          IF
            (${TABLE}.PromoDiffrentialImpactScore>${TABLE}.NonSeasonalTrendsImpactScore,
            IF
              (${TABLE}.PromoDiffrentialImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                'Promo Differential',
                'Forecast Outside Statistical Range'),
            IF
              (${TABLE}.NonSeasonalTrendsImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                'NonSeasonal Trends',
                'Forecast Outside Statistical Range') ),
          IF
            (${TABLE}.ColdFront>${TABLE}.NonSeasonalTrendsImpactScore,
            IF
              (${TABLE}.ColdFront>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                'Cold Front',
                'Forecast Outside Statistical Range'),
            IF
              (${TABLE}.NonSeasonalTrendsImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                'NonSeasonal Trends',
                'Forecast Outside Statistical Range')) ),
        IF
          (${TABLE}.HeatWaveImpactScore>${TABLE}.ColdFront,
          IF
            (${TABLE}.HeatWaveImpactScore>${TABLE}.NonSeasonalTrendsImpactScore,
            IF
              (${TABLE}.HeatWaveImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                'Heat Wave',
                'Forecast Outside Statistical Range'),
            IF
              (${TABLE}.NonSeasonalTrendsImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                'NonSeasonal Trends',
                'Forecast Outside Statistical Range') ),
          IF
            (${TABLE}.ColdFront>${TABLE}.NonSeasonalTrendsImpactScore,
            IF
              (${TABLE}.ColdFront>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                'Cold Front',
                'Forecast Outside Statistical Range'),
            IF
              (${TABLE}.NonSeasonalTrendsImpactScore>${TABLE}.ForecastOutsideStatisticalRangeImpactScore,
                'NonSeasonal Trends',
                'Forecast Outside Statistical Range')) ) ) ;;
    #link: {
      #label: "Detailed Dashboard"
      #url: "/dashboards/cortex_demand_sensing::{{url_field._value}}?Product+Name={{ product_name._value }}&Customer={{customer._value}}&Ship+To+Location={{location._value}}"
      #url: "/dashboards/cortex_demand_sensing::{{url_field._value}}?Product+Name={{ product_name._value }}&Customer={{ customer._value }}&Ship+To+Location={{location._value}}"
           #dashboards/cortex_demand_sensing::demand_sensing__alerts_detail_dashboard_forecast_outside_statistical_range?Product+Name={{ product_name._value }}&Customer={{ customer._value }}&Ship+To+Location={{location._value}}
      #icon_url: "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/279/magnifying-glass-tilted-left_1f50d.png"
   # }
    html: <a href="/dashboards/cortex_demand_sensing::{{url_field._value}}?Product+Name={{ product_name._value }}&Customer={{ customer._value }}&Ship+To+Location={{location._value}}">{{value}}</a>;;
  }

  dimension: url_field {
    hidden: yes
    type: string
    sql:
         CASE
          WHEN ${alert_dashboard_link} = 'Forecast Outside Statistical Range' THEN ('demand_sensing__alerts_detail_dashboard_forecast_outside_statistical_range')
          WHEN ${alert_dashboard_link} = 'Promo Differential' THEN ('demand_sensing__alerts_detail_dashboard_promo_differential')
          WHEN ${alert_dashboard_link} = 'Storm' THEN ('demand_sensing__alerts_detail_dashboard_temperature')
          WHEN ${alert_dashboard_link} = 'Cold Front' THEN ('demand_sensing__alerts_detail_dashboard_temperature')
          WHEN ${alert_dashboard_link} = 'Heat Wave' THEN ('demand_sensing__alerts_detail_dashboard_temperature')
          WHEN ${alert_dashboard_link} = 'NonSeasonal Trends' THEN ('demand_sensing__alerts_detail_dashboard_trends')
          ELSE Null
        END ;;
  }

}
