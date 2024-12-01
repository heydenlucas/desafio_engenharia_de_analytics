with    
    source_product as (
        select 
            cast(PRODUCTID as int) as pk_product
            , cast(PRODUCTSUBCATEGORYID as varchar) as fk_subcategory
            , cast(PRODUCTMODELID as varchar) as fk_model            
            --##########################################
            , cast(MODIFIEDDATE as date) as product_modifieddate
            , ifnull(cast(SELLSTARTDATE as date), NULL) as pruduct_start_sell_dt
            , ifnull(cast(SELLENDDATE as date), NULL) as pruduct_end_sell_dt
            --##########################################
            , cast(PRODUCTNUMBER as varchar) as pd_number
            , cast(NAME as varchar) as product_name
            --##########################################
            -- , cast(ROWGUID as varchar) as
            -- , cast(MAKEFLAG as varchar) as
            -- , cast(FINISHEDGOODSFLAG as varchar) as
            -- , cast(COLOR as varchar) as
            -- , cast(SAFETYSTOCKLEVEL as varchar) as
            -- , cast(REORDERPOINT as varchar) as
            -- , cast(STANDARDCOST as varchar) as
            -- , cast(LISTPRICE as varchar) as
            -- , cast(SIZE as varchar) as
            -- , cast(SIZEUNITMEASURECODE as varchar) as
            -- , cast(WEIGHTUNITMEASURECODE as varchar) as
            -- , cast(WEIGHT as varchar) as
            -- , cast(DAYSTOMANUFACTURE as varchar) as
            -- , cast(PRODUCTLINE as varchar) as
            -- , cast(CLASS as varchar) as
            -- , cast(STYLE as varchar) as
            -- , DISCONTINUEDDATE as pruduct_discontinued_sell_dt
        from {{ source('erp_adventure_works', 'Product') }}
    )

select *
from source_product
