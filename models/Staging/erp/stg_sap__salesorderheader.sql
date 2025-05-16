with
    stg_salesorderheader as (
        select
            cast(salesorderid as int) as salesorderid
            , cast(customerid as int) as customerid
            , cast(creditcardid as int) as creditcardid
            , cast(territoryid as int) as territoryid
            , cast(salespersonid as int) as salespersonid
            , cast(subtotal as numeric) as subtotal
            , cast(taxamt as numeric) as tax
            , cast(freight as numeric) as freight
            , cast(totaldue as numeric) as totaldue
            , cast(shiptoaddressid as int) as shiptoaddressid
            , case  
            when status = 1 then 'In process'
            when status = 2 then 'Approved'
            when status = 3 then 'Backordered'
            when status = 4 then 'Rejected'
            when status = 5 then 'Shipped'
            when status = 6 then 'Cancelled'
            else null
        end as order_status
            , TO_DATE(substr(orderdate, 1, 10), 'YYYY-MM-DD') AS order_date
             , case
                when onlineorderflag = True then 'Online'
                else 'Store'
                end as ordered_online
        from {{ source('raw_adventure_works', 'salesorderheader') }}
)

select *
from stg_salesorderheader