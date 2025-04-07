with 
    stg_person as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(concat(firstname, ' ', lastname) as string) as person_name
        from {{ source('raw_adventure_works', 'person') }}
    )

select *
from stg_person