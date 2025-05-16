with 
    salesorderheader as (
        select 
            distinct(creditcardid)
        from {{ref('stg_sap__salesorderheader')}}
        where creditcardid is not null
    )

    , creditcard as (
        select *
        from {{ref('stg_sap__creditcard')}}
    )

    , newtable as (
      select 
            {{ dbt_utils.generate_surrogate_key(['salesorderheader.creditcardid']) }} as sk_creditcard 
            , salesorderheader.creditcardid
            , creditcard.card_type
        from salesorderheader 
        left join creditcard on salesorderheader.creditcardid = creditcard.creditcardid
    )

select *
from newtable