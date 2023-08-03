- dashboard: demand_sensing__alerts_summary_dashboard
  title: Demand Sensing - Alerts Summary Dashboard
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: G7KplpivR8TpPnKtIflDT4
  elements:
  - title: Untitled
    name: Untitled
    model: cortex_demand_sensing
    explore: demand_sensing_summary
    type: looker_grid
    fields: [demand_sensing_summary.product_name, demand_sensing_summary.customer,
      demand_sensing_summary.location, demand_sensing_summary.date_week, demand_sensing_summary.alert_dashboard_link,
      demand_sensing_summary.impact_score, demand_sensing_summary.thirteen_week_past_sales_volume,
      demand_sensing_summary.fifty_two_past_sales_volume]
    sorts: [demand_sensing_summary.date_week desc, demand_sensing_summary.impact_score
        desc]
    limit: 500
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
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: [demand_sensing_summary.impact_score]}]
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
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    title_hidden: true
    listen:
      Product Name: demand_sensing_summary.product_name
      Customer Name: demand_sensing_summary.customer
      Location: demand_sensing_summary.location
      Week Range: demand_sensing_summary.date_week
      Alert Type: demand_sensing_summary.alert_dashboard_link
    row: 0
    col: 0
    width: 24
    height: 13
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
    model: cortex_demand_sensing
    explore: demand_sensing_summary
    listens_to_filters: []
    field: demand_sensing_summary.product_name
  - name: Customer Name
    title: Customer Name
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: cortex_demand_sensing
    explore: demand_sensing_summary
    listens_to_filters: []
    field: demand_sensing_summary.customer
  - name: Location
    title: Location
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: cortex_demand_sensing
    explore: demand_sensing_summary
    listens_to_filters: []
    field: demand_sensing_summary.location
  - name: Week Range
    title: Week Range
    type: date_filter
    default_value: 90 days
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
  - name: Alert Type
    title: Alert Type
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: cortex_demand_sensing
    explore: demand_sensing_summary
    listens_to_filters: []
    field: demand_sensing_summary.alert_dashboard_link
