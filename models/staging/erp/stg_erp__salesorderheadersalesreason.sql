with
    source_salesorderheadersalesreason as (
        select 
            cast(SALESORDERID as int) as fk_salesorder
            , cast(SALESREASONID as int) as fk_salesreason
            --############################################
            , cast(MODIFIEDDATE as date) as salesreason_modifieddate
            --############################################            
        from {{ source('erp_adventure_works', 'SalesOrderHeaderSalesReason') }}
    )

select *
from source_salesorderheadersalesreason