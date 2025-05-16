with
     salesreason as (
          select *
          from {{ ref('stg_sap__salesreason') }}
     )

     , salesorderheader_salesreason as (
          select
               salesorderid 
               , salesreasonid 
          from {{ ref('stg_sap__salesorderheadersalesreason') }}     
     )

     , new_table as (
          select
          {{ dbt_utils.generate_surrogate_key([
               "salesorderheader_salesreason.salesreasonid"
               , "salesorderheader_salesreason.salesorderid"
               ]) }} as salesreason_sk
          , salesorderheader_salesreason.salesreasonid 
          , salesorderheader_salesreason.salesorderid 
          , salesreason.reason
          , salesreason.reason_type
          from salesorderheader_salesreason
          left join salesreason
               on salesorderheader_salesreason.salesreasonid = salesreason.salesreasonid
     ) 

select *
from new_table