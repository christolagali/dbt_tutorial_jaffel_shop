with customers_cte as (

    select * from {{ ref('stg_customers') }}

),

orders_cte as (

    select * from {{ ref('stg_orders') }}

),

final as (

    select
        customers_cte.customer_id,
        customers_cte.C_NAME,
        customers_cte.C_NATIONKEY,
        orders_cte.most_recent_order_date,
        coalesce(orders_cte.total_price, 0) as accrued_total_price

    from customers_cte

    left join orders_cte using (customer_id)

)

select * from final