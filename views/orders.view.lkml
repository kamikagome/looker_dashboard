view: orders {
  sql_table_name: "stg"."orders" ;;  # Lowercase table name
  drill_fields: [order_id]

  parameter: profit_or_sales {
    type: unquoted
    allowed_value: { value: "Profit" }
    allowed_value: { value: "Sales" }
  }

  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}."order_id" ;;      # Changed to lowercase
  }

  dimension: category {
    type: string
    sql: ${TABLE}."category" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."city" ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."country" ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}."customer_id" ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}."customer_name" ;;
  }

  dimension_group: order {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."order_date" ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}."postal_code" ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}."product_id" ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}."product_name" ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}."quantity" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."region" ;;
  }

  dimension: row_id {
    type: number
    sql: ${TABLE}."row_id" ;;
  }

  dimension: segment {
    type: string
    sql: ${TABLE}."segment" ;;
  }

  dimension_group: ship {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."ship_date" ;;
  }

  dimension: ship_mode {
    type: string
    sql: ${TABLE}."ship_mode" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."state" ;;
    map_layer_name: us_states
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}."subcategory" ;;
  }

  measure: sales {
    type: number
    sql: ${TABLE}."sales" ;;
  }

  measure: total_sales {
    type: sum
    sql: ${TABLE}."sales" ;;
    value_format: "$#,##0"
  }

  measure: profit {
    type: number
    sql: ${TABLE}."profit" ;;
  }

  measure: total_profit {
    type: sum
    sql: ${TABLE}."profit" ;;
    value_format: "$#,##0"
  }

  measure: dynamic_profit_or_sales {
    type: number
    sql: SUM(CASE
            WHEN {% condition profit_or_sales %} 'Profit' {% endcondition %} THEN ${profit}
            ELSE ${sales}
          END) ;;
    value_format: "$#,##0"
    html: "{% if profit_or_sales._parameter_value == 'Profit' %}
          Profit: {{ rendered_value }}
          {% else %}
          Sales: {{ rendered_value }}
          {% endif %}" ;;
  }

  measure: total_customers {
    type: count_distinct
    sql: ${customer_id} ;;
    label: "Total Customers"
  }

  measure: total_orders {
    type: count_distinct
    sql: ${order_id} ;;
    label: "Total Orders"
  }

  measure: discount {
    type: number
    sql: ${TABLE}."discount" ;;
  }

  measure: count {
    type: count
    # Fixed drill field to match your join name 'returns' instead of 'returned_orders'
    drill_fields: [order_id, product_name, customer_name, returns.count]
  }
}
