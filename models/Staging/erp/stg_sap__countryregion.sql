with
    stg_countryregion as (
        select
            countryregioncode 
            , name as country_name
        from {{ source('raw_adventure_works', 'countryregion') }}
    )

select *
from stg_countryregion