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
    , agg_salesreason AS (
        SELECT 
            {{ dbt_utils.generate_surrogate_key(['FK_SALESORDER']) }} AS sk_SALESREASON
            , FK_SALESORDER AS ID_SALESORDER
            , LISTAGG(SALESREASON_NAME, ', ') AS AGG_SALESREASON
            , LISTAGG(SALESREASON_TYPE, ', ') AS AGG_SALESTYPE
        FROM 
            joined
        GROUP BY 
            FK_SALESORDER
)

SELECT *
FROM agg_salesreason


-- Entender se é necessário agregar o motivo da venda e ver como deve-se inserí-lo corretamente na tabela Fato

-- select 
--     count(distinct(FK_SALESORDER)) as ID
--     , count(PK_SALESREASON) as PK
-- from joined