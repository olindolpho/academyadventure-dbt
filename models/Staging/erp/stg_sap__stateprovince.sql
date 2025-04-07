with
    stg_stateprovince as (
        select
            cast(stateprovinceid as int) as stateprovinceid
            , cast(territoryid as int) as territoryid
            , countryregioncode as country_code
            , stateprovincecode as state_code
            , name as state_name
        from {{ source('raw_adventure_works', 'stateprovince') }}
    )

select *
from stg_stateprovince