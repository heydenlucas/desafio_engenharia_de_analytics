with
    source_salesreason as (
        select 
            cast(SALESREASONID as int) as pk_salesreason
            --############################################
            , cast(MODIFIEDDATE as date) as salesreason_modifieddate
            --############################################
            , cast(NAME as varchar) as salesreason_name
            , cast(REASONTYPE as varchar) as salesreason_type
            
        from {{ source('erp_adventure_works', 'SalesReason') }}
    )

select *
from source_salesreason