with 
    stg_store as (
        select
        cast(businessentityid as int) as businessentityid 
        , cast(salespersonid as int) as salespersonid
        , name as store_name
    from {{ source('raw_adventure_works','store') }}
    )

select *
from stg_store