with
    stg_salesperson as (
        select
            cast(businessentityid as int) as salesperson_id
            , cast(salesquota as int) as salesquota
            , cast(salesytd as numeric) as salesytd
            , cast(saleslastyear as numeric) as saleslastyear
        from {{ source('raw_adventure_works', 'salesperson') }}
    )
select *
from stg_salesperson