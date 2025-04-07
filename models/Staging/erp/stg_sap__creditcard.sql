with
    stg_creditcard as (
        select
            cast(creditcardid as int) as creditcardid 
            , cardtype as card_type
        from {{ source('raw_adventure_works', 'creditcard') }}
    )

select * 
from stg_creditcard