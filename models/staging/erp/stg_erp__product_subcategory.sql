with 
    source_product_subcategory as (
        select 
            cast(PRODUCTSUBCATEGORYID as int) as pk_product_subcategory
            , cast(PRODUCTCATEGORYID as int) as fk_product_category
            --############################################
            , cast(MODIFIEDDATE as date) as subcategory_modifieddate
            --############################################
            , cast(NAME as varchar) as subcategory_name
            --############################################
            -- , cast(ROWGUID as varchar) as 
        from {{ source('erp_adventure_works', 'ProductSubcategory') }}
    )

select *
from source_product_subcategory