with
    stg_productsubcategory as (
        select
            cast(productsubcategoryid as int) as productsubcategoryid
            , cast(productcategoryid as int) as productcategoryid
            , name as subcategory_name
        from {{ source('raw_adventure_works', 'productsubcategory') }}
    )

select *
from stg_productsubcategory