with 
    product as (
        select *
        from {{ ref('dim_product') }}
    )
    , creditcard as (
        select *
        from {{ ref('dim_creditcard') }}
    )
    , employee as (
        select *
        from {{ ref('dim_employee') }}
    )
    , location as (
        select 
            PK_SHIP_TO_ADDRESS
            , FULL_ADDRESS
        from {{ ref('dim_location') }}
    )
    , order_details as (
        select 
            PK_ORDER_DETAIL
            , fk_salesorder
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
            --#############################
            , ORDER_DATE
            , DUE_DATE
            , SHIP_DATE
            , MODIFIED_DATE
            --#############################
            , ORDER_QUANTITY
            , UNIT_PRICE
            , UNIT_PRICE_DESC
            , REVISION_NUMBER
            , STATUS
            , ORDER_FLG
            , PURCHASE_ORDER_NUMBER
            , ACCOUNT_NUMBER
            , CREDIT_CARD_APPROVAL_CODE
            , COMMENT
            --############################
            -- Metrics
            , gross_subtotal
            , net_subtotal
            , prorated_freight
            , prorated_tax
        from {{ ref('int_orderdetails') }}
    )
    , sales_reason as (
        select 
            id_SALESORDER
            , AGG_SALESREASON
            , AGG_SALESTYPE
        from {{ ref('dim_salesreason') }}
    )
    , client as (
        select 
            SK_CLIENT
            , PK_CLIENT
            , FK_PERSON
            , FK_STORE
            , FK_TERRITORY
            , PERSON_NAME
            , PERSON_TYPE
            , STORE_NAME
        from {{ ref('dim_client') }}
    )
    , joined as (
        select 
              order_details.PK_ORDER_DETAIL
            , order_details.Fk_salesorder
            , order_details.FK_CUSTOMER
            , order_details.FK_SALES_PERSON
            , order_details.FK_TERRITORY
            , order_details.FK_BILL_TO_ADDRESS
            , order_details.FK_SHIP_TO_ADDRESS
            , order_details.FK_SHIP_METHOD
            , order_details.FK_CREDIT_CARD
            , order_details.FK_CURRENCY_RATED
            , order_details.FK_PRODUCT
            , order_details.FK_SPECIAL_OFFER
            , order_details.FK_TRAKING_NUMBER
            , client.FK_PERSON
            , client.FK_STORE
            --#############################
            -- , ROW_NUMBER() OVER (PARTITION BY order_details.ORDER_DATE ORDER BY order_details.ORDER_DATE) AS rn
            , order_details.ORDER_DATE
            ,  DATE_TRUNC('month', order_details.ORDER_DATE) AS normalized_date
            -- , order_details.DUE_DATE
            , order_details.SHIP_DATE
            -- , order_details.MODIFIED_DATE
            --#############################
            -- , order_details.REVISION_NUMBER
            -- , order_details.ORDER_FLG
            -- , order_details.PURCHASE_ORDER_NUMBER
            -- , order_details.ACCOUNT_NUMBER
            -- , order_details.CREDIT_CARD_APPROVAL_CODE
            -- , order_details.COMMENT
            --############################
            , order_details.STATUS
            , order_details.ORDER_QUANTITY
            , order_details.UNIT_PRICE
            , order_details.UNIT_PRICE_DESC
            , case 
                when client.FK_STORE IS NULL then 'Online'
                when client.FK_STORE IS NOT NULL then 'Physical'
              end as store_kind
            -- Metrics
            , order_details.gross_subtotal
            , order_details.net_subtotal
            , order_details.prorated_freight
            , order_details.prorated_tax
            -----------------------------------------
            --, sales_reason.id_salesorder
            , sales_reason.AGG_SALESREASON
            , sales_reason.AGG_SALESTYPE
            -----------------------------------------
            , creditcard.CARD_TYPE
            -----------------------------------------
            , client.PERSON_NAME
            , client.PERSON_TYPE
            , case 
                    when client.STORE_NAME is null then 'Virtual Store'
                    else client.STORE_NAME
              end as store_name
            -- , client.STORE_NAME
            -----------------------------------------
            , location.FULL_ADDRESS


        from order_details
        left join sales_reason on sales_reason.id_salesorder = ORDER_DETAILS.fk_salesorder
        left join client on client.PK_CLIENT = ORDER_DETAILS.FK_CUSTOMER
        left join location on location.PK_SHIP_TO_ADDRESS = order_details.FK_SHIP_TO_ADDRESS
        left join creditcard on creditcard.PK_CREDIT_CARD = order_details.FK_CREDIT_CARD
    )


select *
from joined 
-- where PERSON_NAME = 'Aaron Edwards'
-- where FK_CREDIT_CARD = 14317
-- where FK_SHIP_TO_ADDRESS = 24768

-- where ORDER_DATE = '2011-06-27'


-- select
--     rn
--     ,ORDER_DATE
--     , gross_subtotal
-- from joined
-- order by rn, ORDER_DATE
