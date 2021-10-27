with customers_cte as (

    select
        C_CUSTKEY as customer_id,
        C_NAME,
        C_NATIONKEY

    from customers

),

orders_cte as (

    select
        O_ORDERKEY as order_id,
        O_CUSTKEY as customer_id,
        MAX(O_ORDERDATE) as most_recent_order_date,
        SUM(O_TOTALPRICE) as total_price

    from orders
    group by 1,2

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