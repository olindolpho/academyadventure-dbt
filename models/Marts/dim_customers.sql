with
    customer as (
        select *
        from {{ref('stg_sap__customer')}}
    ) 

    , person as (
        select *
        from {{ref('stg_sap__person')}}
    ) 

    , store as (
        select *
        from {{ref('stg_sap__store')}}
    ) 

    , first_order as (
        select
            salesorderheader.customerid,
        from {{ ref('stg_sap__salesorderheader') }} as salesorderheader
        group by salesorderheader.customerid
    )

    , joined as (
        select
            customer.customerid
            , customer.personid
            , person.person_name
            , person.businessentityid
            , customer.storeid
            , store.store_name
        from customer
        left join person on person.businessentityid = customer.personid
        left join store on store.businessentityid = customer.storeid
    )

    , newtable as (
        select
            {{ dbt_utils.generate_surrogate_key(['customerid']) }} as sk_customer
            , customerid
            , person_name
            , store_name
            , businessentityid
        from joined
    )

select *
from newtable