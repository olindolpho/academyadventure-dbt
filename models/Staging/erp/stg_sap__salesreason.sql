with
    stg_salesreason as (
        select
            cast(salesreasonid as int) as salesreasonid 
            , name as reason
            , reasontype as reason_type
        from {{ source('raw_adventure_works', 'salesreason') }}
    )

select *
from stg_salesreason