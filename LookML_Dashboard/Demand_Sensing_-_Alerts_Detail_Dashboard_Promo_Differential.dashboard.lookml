- dashboard: demand_sensing__alerts_detail_dashboard_promo_differential
  title: Demand Sensing - Alerts Detail Dashboard (Promo Differential)
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: M9im3qI9R2DcCPXaVIyq8P
  elements:
  - title: Promo Differential
    name: Promo Differential
    model: cortex_demand_sensing
    explore: demand_sensing
    type: looker_line
    fields: [demand_sensing.date_week, demand_sensing.wholesale_quantity_measure,
      average_of_is_promo, average_of_demand_plan_past, demand_sensing.forecast, demand_sensing.forecast_lower,
      demand_sensing.forecast_upper]
    fill_fields: [demand_sensing.date_week]
    sorts: [demand_sensing.date_week desc]
    limit: 500
    dynamic_fields: [{measure: average_of_demand_plan, based_on: demand_sensing.demand_plan,
        expression: '', label: Average of Demand Plan, type: average, _kind_hint: measure,
        _type_hint: number}, {measure: average_of_is_promo, based_on: demand_sensing.is_promo,
        expression: '', label: Average of Is Promo, type: average, _kind_hint: measure,
        _type_hint: number}, {measure: average_of_demand_plan_past, based_on: demand_sensing.demand_plan_past,
        expression: '', label: Average of Demand Plan Past, type: average, _kind_hint: measure,
        _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: Quantity, orientation: left, series: [{axisId: average_of_demand_plan,
            id: average_of_demand_plan, name: Demand Plan}, {axisId: demand_sensing.wholesale_quantity_measure,
            id: demand_sensing.wholesale_quantity_measure, name: Customer Units Sold},
          {axisId: average_of_demand_plan_past, id: average_of_demand_plan_past, name: Average
              of Demand Plan Past}, {axisId: demand_sensing.forecast, id: demand_sensing.forecast,
            name: Forecast}, {axisId: demand_sensing.forecast_upper, id: demand_sensing.forecast_upper,
            name: Forecast Upper}, {axisId: demand_sensing.forecast_lower, id: demand_sensing.forecast_lower,
            name: Forecast Lower}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: average_of_is_promo,
            id: average_of_is_promo, name: Wholesale Promotion}], showLabels: false,
        showValues: false, maxValue: 1, minValue: 0, valueFormat: '0[>0];[<0]', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types:
      average_of_is_promo: column
    series_colors:
      average_of_demand_plan: "#EA4335"
      average_of_is_promo: "#cfd8de"
      demand_sensing.past_sales_quantity: "#F9AB00"
      demand_sensing.wholesale_quantity_measure: "#1A73E8"
      average_of_demand_plan_past: "#EA4335"
      demand_sensing.forecast: "#7CB342"
      demand_sensing.forecast_lower: "#c8de9d"
      demand_sensing.forecast_upper: "#c8de9d"
    series_labels:
      average_of_demand_plan: Demand Plan
      average_of_is_promo: Wholesale Promotion
      demand_sensing.wholesale_quantity_measure: Customer Units Sold
      average_of_demand_plan_past: Demand Plan
      demand_sensing.forecast_lower: Forecast Lower Bound
      demand_sensing.forecast_upper: Forecast Upper Bound
    x_axis_datetime_label: ''
    defaults_version: 1
    hidden_fields: []
    listen:
      Product Name: demand_sensing.product_name
      Customer Name: demand_sensing.customer
      Ship To Location: demand_sensing.location
      Week Range: demand_sensing.date_date
    row: 0
    col: 5
    width: 19
    height: 9
  - title: Google Trends Insights
    name: Google Trends Insights
    model: cortex_demand_sensing
    explore: demand_sensing
    type: looker_line
    fields: [demand_sensing.date_week, average_of_interest_over_time, demand_sensing.wholesale_quantity_measure,
      average_of_demand_plan, demand_sensing.forecast, demand_sensing.forecast_lower,
      demand_sensing.forecast_upper]
    fill_fields: [demand_sensing.date_week]
    filters: {}
    sorts: [demand_sensing.date_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{measure: average_of_interest_over_time, based_on: demand_sensing.interest_over_time,
        expression: '', label: Average of Interest Over Time, type: average, _kind_hint: measure,
        _type_hint: number}, {measure: average_of_demand_plan, based_on: demand_sensing.demand_plan,
        expression: '', label: Average of Demand Plan, type: average, _kind_hint: measure,
        _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: average_of_interest_over_time,
            id: average_of_interest_over_time, name: Trend}], showLabels: true, showValues: true,
        unpinAxis: true, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: right, series: [ {axisId: demand_sensing.wholesale_quantity_measure,
            id: demand_sensing.wholesale_quantity_measure, name: Customer Units Sold},
          {axisId: average_of_demand_plan, id: average_of_demand_plan, name: Total
              Demand Plan}, {axisId: demand_sensing.forecast, id: demand_sensing.forecast,
            name: Forecast}, {axisId: demand_sensing.forecast_lower, id: demand_sensing.forecast_lower,
            name: Forecast Lower Bound}, {axisId: demand_sensing.forecast_upper, id: demand_sensing.forecast_upper,
            name: Forecast Upper Bound}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_colors:
      average_of_interest_over_time: "#E52592"
      average_of_demand_plan: "#EA4335"
      demand_sensing.past_sales_quantity: "#F9AB00"
      demand_sensing.wholesale_quantity_measure: "#1A73E8"
      demand_sensing.forecast: "#7CB342"
      demand_sensing.forecast_lower: "#c8de9d"
      demand_sensing.forecast_upper: "#c8de9d"
    series_labels:
      average_of_interest_over_time: Trend
      average_of_demand_plan: Demand Plan
      demand_sensing.wholesale_quantity_measure: Customer Units Sold
      demand_sensing.forecast_lower: Forecast Lower Bound
      demand_sensing.forecast_upper: Forecast Upper Bound
    x_axis_datetime_label: ''
    defaults_version: 1
    hidden_fields: []
    listen:
      Product Name: demand_sensing.product_name
      Customer Name: demand_sensing.customer
      Ship To Location: demand_sensing.location
      Week Range: demand_sensing.date_date
    row: 9
    col: 8
    width: 8
    height: 7
  - title: Forecast Outside Statistical Range
    name: Forecast Outside Statistical Range
    model: cortex_demand_sensing
    explore: demand_sensing
    type: looker_line
    fields: [demand_sensing.date_week, average_of_demand_plan, demand_sensing.forecast,
      demand_sensing.forecast_lower, demand_sensing.forecast_upper, demand_sensing.wholesale_quantity_measure]
    fill_fields: [demand_sensing.date_week]
    filters: {}
    sorts: [demand_sensing.date_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{measure: average_of_demand_plan, based_on: demand_sensing.demand_plan,
        expression: '', label: Average of Demand Plan, type: average, _kind_hint: measure,
        _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: Quantity, orientation: left, series: [{axisId: average_of_demand_plan,
            id: average_of_demand_plan, name: Total Demand Plan}, {axisId: demand_sensing.forecast,
            id: demand_sensing.forecast, name: Forecast}, {axisId: demand_sensing.forecast_lower,
            id: demand_sensing.forecast_lower, name: Forecast Lower Bound}, {axisId: demand_sensing.forecast_upper,
            id: demand_sensing.forecast_upper, name: Forecast Upper Bound}, {axisId: demand_sensing.wholesale_quantity_measure,
            id: demand_sensing.wholesale_quantity_measure, name: Customer Units Sold}],
        showLabels: true, showValues: true, unpinAxis: true, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_colors:
      average_of_demand_plan: "#EA4335"
      demand_sensing.forecast: "#7CB342"
      demand_sensing.forecast_lower: "#c8de9d"
      demand_sensing.forecast_upper: "#c8de9d"
      demand_sensing.wholesale_quantity_measure: "#1A73E8"
    series_labels:
      average_of_demand_plan: Demand Plan
      demand_sensing.forecast_lower: Forecast Lower Bound
      demand_sensing.forecast_upper: Forecast Upper Bound
      demand_sensing.wholesale_quantity_measure: Customer Units Sold
    x_axis_datetime_label: "%b %y"
    defaults_version: 1
    hidden_fields: []
    listen:
      Product Name: demand_sensing.product_name
      Customer Name: demand_sensing.customer
      Ship To Location: demand_sensing.location
      Week Range: demand_sensing.date_date
    row: 9
    col: 16
    width: 8
    height: 7
  - title: Temperature
    name: Temperature
    model: cortex_demand_sensing
    explore: demand_sensing
    type: looker_line
    fields: [demand_sensing.date_week, demand_sensing.temperature, demand_sensing.forecast_temperature,
      average_of_moving_average, demand_sensing.wholesale_quantity_measure, average_of_demand_plan,
      demand_sensing.forecast, demand_sensing.forecast_upper, demand_sensing.forecast_lower]
    fill_fields: [demand_sensing.date_week]
    filters: {}
    sorts: [demand_sensing.date_week desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{measure: average_of_demand_plan, based_on: demand_sensing.demand_plan,
        expression: '', label: Average of Demand Plan, type: average, _kind_hint: measure,
        _type_hint: number}, {measure: average_of_moving_average, based_on: demand_sensing.moving_average,
        expression: '', label: Average of Moving Average, type: average, _kind_hint: measure,
        _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: Temperature, orientation: left, series: [{axisId: demand_sensing.temperature,
            id: demand_sensing.temperature, name: Temperature}, {axisId: demand_sensing.forecast_temperature,
            id: demand_sensing.forecast_temperature, name: Temperature Forecast},
          {axisId: average_of_moving_average, id: average_of_moving_average, name: Historical
              Average Temperature}], showLabels: true, showValues: true, maxValue: !!null '',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: Quantity, orientation: right, series: [{axisId: demand_sensing.wholesale_quantity_measure,
            id: demand_sensing.wholesale_quantity_measure, name: Customer Units Sold},
          {axisId: average_of_demand_plan, id: average_of_demand_plan, name: Demand
              Plan}, {axisId: demand_sensing.forecast, id: demand_sensing.forecast,
            name: Forecast}, {axisId: demand_sensing.forecast_upper, id: demand_sensing.forecast_upper,
            name: Forecast Upper Bound}, {axisId: demand_sensing.forecast_lower, id: demand_sensing.forecast_lower,
            name: Forecast Lower Bound}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types:
      demand_sensing.temperature: column
      demand_sensing.forecast_temperature: column
    series_colors:
      average_of_demand_plan: "#EA4335"
      average_of_moving_average: "#80868B"
      demand_sensing.temperature: "#12B5CB"
      demand_sensing.forecast_temperature: "#a7ccc2"
      demand_sensing.past_sales_quantity: "#F9AB00"
      demand_sensing.wholesale_quantity_measure: "#1A73E8"
      demand_sensing.forecast: "#7CB342"
      demand_sensing.forecast_upper: "#c8de9d"
      demand_sensing.forecast_lower: "#c8de9d"
    series_labels:
      average_of_demand_plan: Demand Plan
      average_of_moving_average: Historical Average Temperature
      demand_sensing.forecast_temperature: Temperature Forecast
      demand_sensing.wholesale_quantity_measure: Customer Units Sold
      demand_sensing.forecast_upper: Forecast Upper Bound
      demand_sensing.forecast_lower: Forecast Lower Bound
    x_axis_datetime_label: ''
    defaults_version: 1
    hidden_fields: []
    listen:
      Product Name: demand_sensing.product_name
      Customer Name: demand_sensing.customer
      Ship To Location: demand_sensing.location
      Week Range: demand_sensing.date_date
    row: 9
    col: 0
    width: 8
    height: 7
  - title: New Tile
    name: New Tile
    model: cortex_demand_sensing
    explore: demand_sensing
    type: single_value
    fields: [demand_sensing.thirteen_week_forecast]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Sales Qty - 13 Week Forecast
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '12'
    orientation: vertical
    style_demand_sensing.thirteen_week_forecast: "#3A4245"
    show_title_demand_sensing.thirteen_week_forecast: true
    title_override_demand_sensing.thirteen_week_forecast: Sales Qty - 13 Week Forecast
    title_placement_demand_sensing.thirteen_week_forecast: above
    value_format_demand_sensing.thirteen_week_forecast: ''
    style_demand_sensing.thirteen_week_sales_volume: "#3A4245"
    show_title_demand_sensing.thirteen_week_sales_volume: true
    title_override_demand_sensing.thirteen_week_sales_volume: Sales Qty - Last 13
      Weeks
    title_placement_demand_sensing.thirteen_week_sales_volume: above
    value_format_demand_sensing.thirteen_week_sales_volume: ''
    show_comparison_demand_sensing.thirteen_week_sales_volume: false
    style_demand_sensing.fifty_two_week_sales_volume: "#3A4245"
    show_title_demand_sensing.fifty_two_week_sales_volume: true
    title_override_demand_sensing.fifty_two_week_sales_volume: Sales Qty - Last 52
      Weeks
    title_placement_demand_sensing.fifty_two_week_sales_volume: above
    value_format_demand_sensing.fifty_two_week_sales_volume: ''
    show_comparison_demand_sensing.fifty_two_week_sales_volume: false
    style_di_demand_shaping.thirteen_week_forecast: "#3A4245"
    show_title_di_demand_shaping.thirteen_week_forecast: true
    title_override_di_demand_shaping.thirteen_week_forecast: 13-Week Forecast
    title_placement_di_demand_shaping.thirteen_week_forecast: below
    value_format_di_demand_shaping.thirteen_week_forecast: ''
    style_di_demand_shaping.thirteen_week_sales_volume: "#3A4245"
    show_title_di_demand_shaping.thirteen_week_sales_volume: true
    title_override_di_demand_shaping.thirteen_week_sales_volume: 13-Week Customer
      Sales Units
    title_placement_di_demand_shaping.thirteen_week_sales_volume: below
    value_format_di_demand_shaping.thirteen_week_sales_volume: ''
    show_comparison_di_demand_shaping.thirteen_week_sales_volume: false
    style_di_demand_shaping.fifty_two_week_sales_volume: "#3A4245"
    show_title_di_demand_shaping.fifty_two_week_sales_volume: true
    title_override_di_demand_shaping.fifty_two_week_sales_volume: 52-Week Customer
      Sales Units
    title_placement_di_demand_shaping.fifty_two_week_sales_volume: below
    value_format_di_demand_shaping.fifty_two_week_sales_volume: ''
    show_comparison_di_demand_shaping.fifty_two_week_sales_volume: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    y_axes: []
    listen:
      Product Name: demand_sensing.product_name
      Customer Name: demand_sensing.customer
      Ship To Location: demand_sensing.location
      Week Range: demand_sensing.date_date
    row: 0
    col: 0
    width: 5
    height: 3
  - title: New Tile
    name: New Tile (2)
    model: cortex_demand_sensing
    explore: demand_sensing
    type: single_value
    fields: [demand_sensing.thirteen_week_sales_volume]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Sales Qty - Last 13 Weeks
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '12'
    orientation: vertical
    style_demand_sensing.thirteen_week_forecast: "#3A4245"
    show_title_demand_sensing.thirteen_week_forecast: true
    title_override_demand_sensing.thirteen_week_forecast: Sales Qty - 13 Week Forecast
    title_placement_demand_sensing.thirteen_week_forecast: above
    value_format_demand_sensing.thirteen_week_forecast: ''
    style_demand_sensing.thirteen_week_sales_volume: "#3A4245"
    show_title_demand_sensing.thirteen_week_sales_volume: true
    title_override_demand_sensing.thirteen_week_sales_volume: Sales Qty - Last 13
      Weeks
    title_placement_demand_sensing.thirteen_week_sales_volume: above
    value_format_demand_sensing.thirteen_week_sales_volume: ''
    show_comparison_demand_sensing.thirteen_week_sales_volume: false
    style_demand_sensing.fifty_two_week_sales_volume: "#3A4245"
    show_title_demand_sensing.fifty_two_week_sales_volume: true
    title_override_demand_sensing.fifty_two_week_sales_volume: Sales Qty - Last 52
      Weeks
    title_placement_demand_sensing.fifty_two_week_sales_volume: above
    value_format_demand_sensing.fifty_two_week_sales_volume: ''
    show_comparison_demand_sensing.fifty_two_week_sales_volume: false
    style_di_demand_shaping.thirteen_week_forecast: "#3A4245"
    show_title_di_demand_shaping.thirteen_week_forecast: true
    title_override_di_demand_shaping.thirteen_week_forecast: 13-Week Forecast
    title_placement_di_demand_shaping.thirteen_week_forecast: below
    value_format_di_demand_shaping.thirteen_week_forecast: ''
    style_di_demand_shaping.thirteen_week_sales_volume: "#3A4245"
    show_title_di_demand_shaping.thirteen_week_sales_volume: true
    title_override_di_demand_shaping.thirteen_week_sales_volume: 13-Week Customer
      Sales Units
    title_placement_di_demand_shaping.thirteen_week_sales_volume: below
    value_format_di_demand_shaping.thirteen_week_sales_volume: ''
    show_comparison_di_demand_shaping.thirteen_week_sales_volume: false
    style_di_demand_shaping.fifty_two_week_sales_volume: "#3A4245"
    show_title_di_demand_shaping.fifty_two_week_sales_volume: true
    title_override_di_demand_shaping.fifty_two_week_sales_volume: 52-Week Customer
      Sales Units
    title_placement_di_demand_shaping.fifty_two_week_sales_volume: below
    value_format_di_demand_shaping.fifty_two_week_sales_volume: ''
    show_comparison_di_demand_shaping.fifty_two_week_sales_volume: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    y_axes: []
    listen:
      Product Name: demand_sensing.product_name
      Customer Name: demand_sensing.customer
      Ship To Location: demand_sensing.location
      Week Range: demand_sensing.date_date
    row: 3
    col: 0
    width: 5
    height: 3
  - title: New Tile
    name: New Tile (3)
    model: cortex_demand_sensing
    explore: demand_sensing
    type: single_value
    fields: [demand_sensing.fifty_two_week_sales_volume]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Sales Qty - Last 52 Weeks
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '12'
    orientation: vertical
    style_demand_sensing.thirteen_week_forecast: "#3A4245"
    show_title_demand_sensing.thirteen_week_forecast: true
    title_override_demand_sensing.thirteen_week_forecast: Sales Qty - 13 Week Forecast
    title_placement_demand_sensing.thirteen_week_forecast: above
    value_format_demand_sensing.thirteen_week_forecast: ''
    style_demand_sensing.thirteen_week_sales_volume: "#3A4245"
    show_title_demand_sensing.thirteen_week_sales_volume: true
    title_override_demand_sensing.thirteen_week_sales_volume: Sales Qty - Last 13
      Weeks
    title_placement_demand_sensing.thirteen_week_sales_volume: above
    value_format_demand_sensing.thirteen_week_sales_volume: ''
    show_comparison_demand_sensing.thirteen_week_sales_volume: false
    style_demand_sensing.fifty_two_week_sales_volume: "#3A4245"
    show_title_demand_sensing.fifty_two_week_sales_volume: true
    title_override_demand_sensing.fifty_two_week_sales_volume: Sales Qty - Last 52
      Weeks
    title_placement_demand_sensing.fifty_two_week_sales_volume: above
    value_format_demand_sensing.fifty_two_week_sales_volume: ''
    show_comparison_demand_sensing.fifty_two_week_sales_volume: false
    style_di_demand_shaping.thirteen_week_forecast: "#3A4245"
    show_title_di_demand_shaping.thirteen_week_forecast: true
    title_override_di_demand_shaping.thirteen_week_forecast: 13-Week Forecast
    title_placement_di_demand_shaping.thirteen_week_forecast: below
    value_format_di_demand_shaping.thirteen_week_forecast: ''
    style_di_demand_shaping.thirteen_week_sales_volume: "#3A4245"
    show_title_di_demand_shaping.thirteen_week_sales_volume: true
    title_override_di_demand_shaping.thirteen_week_sales_volume: 13-Week Customer
      Sales Units
    title_placement_di_demand_shaping.thirteen_week_sales_volume: below
    value_format_di_demand_shaping.thirteen_week_sales_volume: ''
    show_comparison_di_demand_shaping.thirteen_week_sales_volume: false
    style_di_demand_shaping.fifty_two_week_sales_volume: "#3A4245"
    show_title_di_demand_shaping.fifty_two_week_sales_volume: true
    title_override_di_demand_shaping.fifty_two_week_sales_volume: 52-Week Customer
      Sales Units
    title_placement_di_demand_shaping.fifty_two_week_sales_volume: below
    value_format_di_demand_shaping.fifty_two_week_sales_volume: ''
    show_comparison_di_demand_shaping.fifty_two_week_sales_volume: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    y_axes: []
    listen:
      Product Name: demand_sensing.product_name
      Customer Name: demand_sensing.customer
      Ship To Location: demand_sensing.location
      Week Range: demand_sensing.date_date
    row: 6
    col: 0
    width: 5
    height: 3
  filters:
  - name: Product Name
    title: Product Name
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options: []
    model: cortex_demand_sensing
    explore: demand_sensing
    listens_to_filters: []
    field: demand_sensing.product_name
  - name: Customer Name
    title: Customer Name
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options: []
    model: cortex_demand_sensing
    explore: demand_sensing
    listens_to_filters: []
    field: demand_sensing.customer
  - name: Ship To Location
    title: Ship To Location
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options: []
    model: cortex_demand_sensing
    explore: demand_sensing
    listens_to_filters: []
    field: demand_sensing.location
  - name: Week Range
    title: Week Range
    type: date_filter
    default_value: 90 days
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
