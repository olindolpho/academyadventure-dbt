with
     stg_product as (
          select
            cast(productid as int) as productid
            , cast(productsubcategoryid as int) as productsubcategoryid
            , name as product_name
            , color as productcolor
            , listprice 
          from {{ source('raw_adventure_works','product') }}
     )

select * from stg_product