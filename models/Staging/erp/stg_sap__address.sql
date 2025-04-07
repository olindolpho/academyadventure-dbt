with
    stg_address as (
        select
        cast(addressid as int) as addressid
        , cast(stateprovinceid as int) as stateprovinceid
        , city
        from {{ source('raw_adventure_works', 'address') }}
    )

select *
from stg_address