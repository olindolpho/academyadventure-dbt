WITH customers AS (
    SELECT
        sk_customer AS fk_customer,
        customerid
    FROM {{ ref('dim_customers') }}
),

creditcards AS (
    SELECT
        sk_creditcard AS fk_creditcard,
        creditcardid
    FROM {{ ref('dim_creditcards') }}
),

locations as (
    select
        sk_shiptoaddress as fk_shiptoaddress
        , shiptoaddressid
    from {{ref('dim_locations')}}
),

products AS (
    SELECT
        sk_product AS fk_product,
        productid
    FROM {{ ref('dim_products') }}
),

dates AS (
        select *
        from {{ ref('dim_dates')}}
),

salesreasons_aggregated AS (
    SELECT
        salesreason_sk AS fk_salesreason,
        salesorderid
    FROM {{ ref('dim_salesreason') }}
),

salesorderdetail AS (
    SELECT *
    FROM {{ ref('stg_sap__salesorderdetail') }}
),

salesorderheader AS (
    SELECT *
    FROM {{ ref('stg_sap__salesorderheader') }}
),

final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['salesorderdetail.salesorderdetailid']) }} AS sk_factsales,
        p.fk_product,
        c.fk_customer,
        cc.fk_creditcard,
        l.fk_shiptoaddress,
        sr.fk_salesreason,
        salesorderdetail.salesorderdetailid,
        soh.salespersonid,
        soh.salesorderid,
        soh.territoryid,
        salesorderdetail.unitprice,
        salesorderdetail.orderqty,
        salesorderdetail.discount,
        soh.ordered_online,
        soh.totaldue,
        soh.order_status,
        d.sk_date
    FROM salesorderdetail
    LEFT JOIN salesorderheader soh
        ON salesorderdetail.salesorderid = soh.salesorderid
    LEFT JOIN products p
        ON salesorderdetail.productid = p.productid
    LEFT JOIN customers c
        ON soh.customerid = c.customerid
    LEFT JOIN creditcards cc
        ON soh.creditcardid = cc.creditcardid
    LEFT JOIN dates d
        ON soh.order_date = d.date_day
    LEFT JOIN salesreasons_aggregated sr
        ON soh.salesorderid = sr.salesorderid
    LEFT JOIN locations l
        ON soh.shiptoaddressid = l.shiptoaddressid
)

SELECT *
FROM final