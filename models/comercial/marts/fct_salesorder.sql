with
    salesorderheader as (
        select 
            PK_ORDERHEADER
            , FK_CUSTOMER
            , FK_SALES_PERSON
            , FK_TERRITORY
            , FK_BILL_TO_ADDRESS
            , FK_SHIP_TO_ADDRESS
            , FK_SHIP_METHOD
            , FK_CREDIT_CARD
            , FK_CURRENCY_RATED
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
            , SUBTOTAL
            , TAX_AMT
            , FREIGHT
            , TOTAL_COST
            , COMMENT
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , salesorderdetail as (
        select
            PK_ORDER_DETAIL
            , FK_ORDERHEADER
            , FK_PRODUCT
            , FK_SPECIAL_OFFER
            , FK_TRAKING_NUMBER
            , MODIFIED_DATE
            , ORDER_QUANTITY
            , UNIT_PRICE
            , UNIT_PRICE_DESC
        from {{ ref('stg_erp__salesorderdetail') }}
    )

    , joined as (
        select
            -- SalesOrderHeader
            PK_ORDERHEADER
            , salesorderheader.FK_CUSTOMER
            , salesorderheader.FK_SALES_PERSON
            , salesorderheader.FK_TERRITORY
            , salesorderheader.FK_BILL_TO_ADDRESS
            , salesorderheader.FK_SHIP_TO_ADDRESS
            , salesorderheader.FK_SHIP_METHOD
            , salesorderheader.FK_CREDIT_CARD
            , salesorderheader.FK_CURRENCY_RATED
            , salesorderheader.ORDER_DATE
            , salesorderheader.DUE_DATE
            , salesorderheader.SHIP_DATE
            --, salesorderheader.MODIFIED_DATE
            , salesorderheader.REVISION_NUMBER
            , salesorderheader.STATUS
            , salesorderheader.ORDER_FLG
            , salesorderheader.PURCHASE_ORDER_NUMBER
            , salesorderheader.ACCOUNT_NUMBER
            , salesorderheader.CREDIT_CARD_APPROVAL_CODE
            , salesorderheader.SUBTOTAL
            , salesorderheader.TAX_AMT
            , salesorderheader.FREIGHT
            , salesorderheader.TOTAL_COST
            , salesorderheader.COMMENT
            -- SalesOrderDetail
            , salesorderdetail.PK_ORDER_DETAIL
            , salesorderdetail.FK_ORDERHEADER
            , salesorderdetail.FK_PRODUCT
            , salesorderdetail.FK_SPECIAL_OFFER
            , salesorderdetail.FK_TRAKING_NUMBER
            , salesorderdetail.MODIFIED_DATE
            , salesorderdetail.ORDER_QUANTITY
            , salesorderdetail.UNIT_PRICE
            , salesorderdetail.UNIT_PRICE_DESC
        from salesorderdetail
        left join salesorderheader on salesorderheader.pk_orderheader = salesorderdetail.fk_orderheader 
    )

    , metrics as (
        select
            *
            -- , PK_ORDERHEADER
            -- , FK_CUSTOMER
            -- , FK_SALES_PERSON
            -- , FK_TERRITORY
            -- , FK_BILL_TO_ADDRESS
            -- , FK_SHIP_TO_ADDRESS
            -- , FK_SHIP_METHOD
            -- , FK_CREDIT_CARD
            -- , FK_CURRENCY_RATED
            -- , FK_ORDERHEADER
            -- , FK_PRODUCT
            -- , FK_SPECIAL_OFFER
            -- , FK_TRAKING_NUMBER
            -- , ORDER_DATE
            -- , DUE_DATE
            -- , SHIP_DATE
            -- , MODIFIED_DATE
            -- , REVISION_NUMBER
            -- , STATUS
            -- , ORDER_FLG
            -- , PURCHASE_ORDER_NUMBER
            -- , ACCOUNT_NUMBER
            -- , CREDIT_CARD_APPROVAL_CODE
            
            -- , TAX_AMT
            -- , FREIGHT
            -- , TOTAL_COST
            -- , COMMENT
            -- --, PK_ORDER_DETAIL
            -- , ORDER_QUANTITY
            -- , UNIT_PRICE
            -- , UNIT_PRICE_DESC

            --##############################################
            , (UNIT_PRICE * ORDER_QUANTITY) as gross_subtotal
            , (UNIT_PRICE * ORDER_QUANTITY - (1-UNIT_PRICE_DESC)) as net_subtotal
            , FREIGHT / (count(*) over(partition by PK_ORDERHEADER)) as prorated_freight

        from joined
    )

select 
    pk_orderheader
    , pk_order_detail
    , subtotal
    , gross_subtotal
    , prorated_freight
    , freight
from metrics



-- select count(*)
-- from {{ ref('stg_erp__salesorderheader') }}

-- select count(*)
-- from {{ ref('stg_erp__salesorderdetail') }}