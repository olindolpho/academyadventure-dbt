with
    stg_salesorderdetail as (
        select
            cast(salesorderdetailid as int) as salesorderdetailid 
            , cast(salesorderid as int) as salesorderid 
            , cast(productid as int) as productid
            , cast(orderqty as int) as orderqty 
            , cast(unitprice as numeric) as unitprice 
            , cast(unitpricediscount as numeric) as discount
        from {{ source('raw_adventure_works', 'salesorderdetail') }}
    )

select *
from stg_salesorderdetail