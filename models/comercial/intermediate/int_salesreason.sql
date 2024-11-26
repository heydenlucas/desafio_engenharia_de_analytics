with 
    salesreason as (
        select 
            PK_SALESREASON
            , SALESREASON_MODIFIEDDATE
            , SALESREASON_NAME
            , SALESREASON_TYPE
        from {{ ref('stg_erp__salesreason') }}
    )
    , salesorderheadersalesreason as (
        select 
            FK_SALESORDER
            , FK_SALESREASON
            , SALESREASON_MODIFIEDDATE
        from {{ ref('stg_erp__salesorderheadersalesreason') }}
    )
    , joined as (
        select 
            salesreason.PK_SALESREASON
            , salesorderheadersalesreason.FK_SALESORDER
            --##################################################
            , salesreason.SALESREASON_MODIFIEDDATE as salesreason_modifiedate
            , salesorderheadersalesreason.SALESREASON_MODIFIEDDATE as salesorderheaderreason_modifiedate
            --##################################################
            , salesreason.SALESREASON_NAME
            , salesreason.SALESREASON_TYPE
            --##################################################
            -- , salesorderheadersalesreason.FK_SALESREASON
        from salesreason
        left join salesorderheadersalesreason 
            on salesreason.PK_SALESREASON = salesorderheadersalesreason.FK_SALESREASON
    )

select *
from joined