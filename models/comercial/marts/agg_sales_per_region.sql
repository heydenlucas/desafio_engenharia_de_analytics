with 
    territory as (
        select 
            PK_TERRITORY
            , TERRITORY_MODIFIEDDATE
            , TERRITORY_NAME
            , COUNTRY_CODE
            , ACCUMULATED_SALES
            , LAST_YEAR_SALES
        from {{ ref('stg_erp__salesterritory') }}
    )
    , location as (
        select 
            PK_ADDRESS
            , CITY
            , ADDRESS
            , NEIGHBORHOOD
            , POSTAL_CODE
            , STATE_NAME
            , COUNTRY_NAME
            , FULL_ADDRESS
        from {{ ref('int_location') }}
    )
    , orderdetails as (
        select 
            PK_ORDER_DETAIL
            , FK_SALESORDER
            , FK_CUSTOMER
            , FK_SALES_PERSON
            , FK_TERRITORY
            , FK_BILL_TO_ADDRESS
            , FK_SHIP_TO_ADDRESS
            , FK_SHIP_METHOD
            , FK_CREDIT_CARD
            , FK_CURRENCY_RATED
            , FK_PRODUCT
            , FK_SPECIAL_OFFER
            , FK_TRAKING_NUMBER
            , ORDER_DATE
            , DUE_DATE
            , SHIP_DATE
            , MODIFIED_DATE
            , REVISION_NUMBER
            , STATUS
            , ORDER_FLG
            , PURCHASE_ORDER_NUMBER
            , ACCOUNT_NUMBER
            , CREDIT_CARD_APPROVAL_CODE
            , COMMENT
            , ORDER_QUANTITY
            , GROSS_SUBTOTAL
            , NET_SUBTOTAL
            , PRORATED_FREIGHT
            , PRORATED_TAX
        from {{ ref('int_orderdetails') }}
    )
    , orders as (
        select *
        from {{ ref('stg_erp__salesorderheader') }}
    )
    , joined as (
        select 
            ord.PK_SALESORDER
            , lc.NEIGHBORHOOD
            , lc.STATE_NAME
            , lc.COUNTRY_NAME
            , tr.TERRITORY_NAME
            , tr.ACCUMULATED_SALES
            , tr.LAST_YEAR_SALES
            , od.GROSS_SUBTOTAL
            , od.ORDER_QUANTITY
        from orders as ord
        left join orderdetails as od on ord.PK_SALESORDER = od.FK_SALESORDER
        left join territory as tr on tr.pk_territory = od.FK_TERRITORY
        left join location as lc on lc.PK_ADDRESS = od.FK_SHIP_TO_ADDRESS
    )
    , metricts as (
        select 
            PK_SALESORDER
            , NEIGHBORHOOD
            , STATE_NAME
            , COUNTRY_NAME
            , TERRITORY_NAME
            -- , ACCUMULATED_SALES
            -- , LAST_YEAR_SALES
            , sum(ORDER_QUANTITY) as product_qty
            , count(PK_SALESORDER) as order_qty
            , round(sum(GROSS_SUBTOTAL),2) as sales_value
        from joined
        group by
            PK_SALESORDER
            , NEIGHBORHOOD
            , STATE_NAME
            , COUNTRY_NAME
            , TERRITORY_NAME
    )

select *
from metricts
-- where PK_SALESORDER = 74554