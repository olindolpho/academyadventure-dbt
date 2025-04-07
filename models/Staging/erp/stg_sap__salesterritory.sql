with
    stg_salesterritory as (
        select
            cast(territoryid as int) as territoryid
            , name as region
            , countryregioncode as country_code
            , `group` as continent
            , cast(salesytd as numeric) as regionsalesyear
            , cast(saleslastyear as numeric) as regionsaleslastyear
        from {{ source('raw_adventure_works', 'salesterritory') }}
    )
select *
from stg_salesterritory