select
        O_ORDERKEY as order_id,
        O_CUSTKEY as customer_id,
        MAX(O_ORDERDATE) as most_recent_order_date,
        SUM(O_TOTALPRICE) as total_price

    from orders
    group by 1,2