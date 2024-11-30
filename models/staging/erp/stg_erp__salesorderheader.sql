with 
    source_salesorderheader as (
        select 
            cast(SALESORDERID as int) as pk_salesorder
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
            , CASE 
                WHEN Status = 1 THEN 'Em processo'
                WHEN Status = 2 THEN 'Aprovado'
                WHEN Status = 3 THEN 'Em falta'
                WHEN Status = 4 THEN 'Rejeitado'
                WHEN Status = 5 THEN 'Enviado'
                WHEN Status = 6 THEN 'Cancelado'
                ELSE 'Status desconhecido' -- Para tratar casos não mapeados
              END AS Status
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

