with 
    source_salesorderheader as (
        select 
            cast(SALESORDERID as int) as pk_orderheader
            --###############################################
            , cast(CUSTOMERID as int) as fk_customer
            , cast(SALESPERSONID as int) as fk_sales_person
            , cast(TERRITORYID as int) as fk_territory
            , cast(BILLTOADDRESSID as int) as fk_bill_to_address
            , cast(SHIPTOADDRESSID as int) as fk_ship_to_address
            , cast(SHIPMETHODID as int) as fk_ship_method
            , cast(CREDITCARDID as int) as fk_credit_card
            , cast(CURRENCYRATEID as varchar) as fk_currency_rated
            --###############################################
            , cast(ORDERDATE as date) as order_date
            , cast(DUEDATE as date) as due_date
            , cast(SHIPDATE as date) as ship_date
            , cast(MODIFIEDDATE as date) as modified_date
            --###############################################
            , cast(REVISIONNUMBER as int) as revision_number
            , cast(STATUS as int) as status
            , cast(ONLINEORDERFLAG as boolean) as order_flg
            , cast(PURCHASEORDERNUmber as varchar) as purchase_order_number
            , cast(ACCOUNTNUMBER as varchar) as account_number
            , cast(CREDITCARDAPPROVALCODE as varchar) as credit_card_approval_code
            , cast(SUBTOTAL as numeric(18,6)) as subtotal
            , cast(TAXAMT as numeric(18,6)) as tax_amt
            , cast(FREIGHT as numeric(18,6)) as freight
            , cast(TOTALDUE as numeric(18,6)) as total_cost
            , cast(COMMENT as varchar) as comment
            --###############################################
            --, cast(ROWGUID as varchar) as
        from {{ source('erp_adventure_works', 'SalesOrderHeader') }}
    )

select *
from source_salesorderheader

