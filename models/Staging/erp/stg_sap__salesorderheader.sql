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
        from {{ source('raw_adventure_works', 'salesorderheader') }}
)

select *
from stg_salesorderheader