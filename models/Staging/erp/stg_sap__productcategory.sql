with
    stg_productcategory as (
        select
            cast(productcategoryid as int) as productcategoryid
            , name as category_name
        from {{ source('raw_adventure_works', 'productcategory') }}
    )

select *
from stg_productcategory