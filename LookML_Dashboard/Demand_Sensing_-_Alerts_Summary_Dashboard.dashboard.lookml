- dashboard: demand_sensing__alerts_summary_dashboard
  title: Demand Sensing - Alerts Summary Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - title: ''
    name: ''
    model: cortex_demand_sensing
    explore: demand_sensing
    type: looker_grid
    fields: [demand_sensing.product_name, demand_sensing.customer, demand_sensing.location,
      demand_sensing.date_date, demand_sensing.alert_dashboard_link, demand_sensing.impact_score,
      demand_sensing.thirteen_week_past_sales_volume, demand_sensing.fifty_two_past_sales_volume]
    sorts: [demand_sensing.impact_score desc]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_labels:
      demand_sensing.location: Ship To Location
      demand_sensing.date_date: Date
      demand_sensing.thirteen_week_past_sales_volume: 13 - Week Customer Sales
      demand_sensing.fifty_two_past_sales_volume: 52 - Week Customer Sales
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: [demand_sensing.impact_score]}]
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
    listen:
      Product Name: demand_sensing.product_name
      Customer Name: demand_sensing.customer
      Ship To Location: demand_sensing.location
      Date Range: demand_sensing.date_date
      Alert Value: demand_sensing.alert_dashboard_link
      Impact Score: demand_sensing.impact_score
    row: 0
    col: 0
    width: 24
    height: 13
  filters:
  - name: Product Name
    title: Product Name
    type: field_filter
    default_value: ''
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
  - name: Alert Value
    title: Alert Value
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: cortex_demand_sensing
    explore: demand_sensing
    listens_to_filters: []
    field: demand_sensing.alert_dashboard_link
  - name: Impact Score
    title: Impact Score
    type: field_filter
    default_value: "[0,100]"
    allow_multiple_values: true
    required: false
    ui_config:
      type: range_slider
      display: inline
      options: []
    model: cortex_demand_sensing
    explore: demand_sensing
    listens_to_filters: []
    field: demand_sensing.impact_score
  - name: Date Range
    title: Date Range
    type: date_filter
    default_value: 90 days
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: cortex_demand_sensing
    explore: demand_sensing
    listens_to_filters: []
    field: demand_sensing.date_date
