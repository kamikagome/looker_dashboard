include: "/views/*.view.lkml"

explore: kamil_orders {
  label: "Kamil Superstore"
  view_name: orders          # Keeps the base view as 'orders'

  join: returns {
    type: left_outer
    relationship: one_to_many
    sql_on: ${returns.order_id} = ${orders.order_id} ;;
  }

  join: people {
    type: inner
    relationship: many_to_one
    sql_on: ${people.region} = ${orders.region} ;;
  }
}
