view: demand_sensing_summary {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: (
  (SELECT
  Date,
  Client_MANDT,
  ProductName,
  Customer,
  Location,
  'Promo Differential' AS alert_dashboard_link,
  PromoDiffrentialImpactScore AS Impact_Score,
  Past13WeekSales,
  Past52WeekSales,
FROM
  ${demand_sensing_pdt.SQL_TABLE_NAME} AS demand_sensing_pdt
where PromoDiffrentialImpactScore > 0)

Union All

(SELECT
  Date,
  Client_MANDT,
  ProductName,
  Customer,
  Location,
  'Heat Wave' AS alert_dashboard_link,
  HeatWaveImpactScore AS Impact_Score,
  Past13WeekSales,
  Past52WeekSales,
FROM
  ${demand_sensing_pdt.SQL_TABLE_NAME} AS demand_sensing_pdt
where HeatWaveImpactScore > 0)

Union All

(SELECT
  Date,
  Client_MANDT,
  ProductName,
  Customer,
  Location,
  'Cold Front' AS alert_dashboard_link,
  ColdFrontImpactScore AS Impact_Score,
  Past13WeekSales,
  Past52WeekSales,
FROM
  ${demand_sensing_pdt.SQL_TABLE_NAME} AS demand_sensing_pdt
where ColdFrontImpactScore > 0)

Union All

(SELECT
  Date,
  Client_MANDT,
  ProductName,
  Customer,
  Location,
  'Forecast Outside Statistical Range' AS alert_dashboard_link,
  ForecastOutsideStatisticalRangeImpactScore AS Impact_Score,
  Past13WeekSales,
  Past52WeekSales,
FROM
  ${demand_sensing_pdt.SQL_TABLE_NAME} AS demand_sensing_pdt
where ForecastOutsideStatisticalRangeImpactScore > 0)

Union All

(SELECT
  Date,
  Client_MANDT,
  ProductName,
  Customer,
  Location,
  'Non Seasonal Trends' AS alert_dashboard_link,
  NonSeasonalTrendsImpactScore AS Impact_Score,
  Past13WeekSales,
  Past52WeekSales,
FROM
  ${demand_sensing_pdt.SQL_TABLE_NAME} AS demand_sensing_pdt
where NonSeasonalTrendsImpactScore > 0)
)
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

  dimension: location {
    type: string
    sql: ${TABLE}.Location ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.ProductName ;;
  }

  dimension: thirteen_week_past_sales_volume{
    type: number
    sql:${TABLE}.Past13WeekSales;;
  }

  dimension: fifty_two_past_sales_volume {
    type: number
    sql:${TABLE}.Past52WeekSales;;
  }

  dimension: impact_score {
    type: number
    sql: ${TABLE}.Impact_Score ;;
  }

  dimension: alert_dashboard_link {
    type: string
    sql: ${TABLE}.alert_dashboard_link ;;
    html: <a href="/dashboards/cortex_demand_sensing::{{url_field._value}}?Product+Name={{ product_name._value }}&Customer={{ customer._value }}&Ship+To+Location={{location._value}}" target="_blank">{{value}}</a>;;
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
          WHEN ${alert_dashboard_link} = 'Non Seasonal Trends' THEN ('demand_sensing__alerts_detail_dashboard_trends')
          ELSE Null
        END ;;
    }

  }
