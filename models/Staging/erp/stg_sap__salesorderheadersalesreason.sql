with
    stg_salesorderheadersalesreason as (
        select
            cast(salesorderid as int) as salesorderid 
            , cast(salesreasonid as int) as salesreasonid 
            from {{ source('raw_adventure_works', 'salesorderheadersalesreason') }}
    )

select *
from stg_salesorderheadersalesreason