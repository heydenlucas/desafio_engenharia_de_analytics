with 
    source_product_category as (
        select 
            cast(PRODUCTCATEGORYID as int) as pk_product_category
            --############################################
            , cast(MODIFIEDDATE as date) as category_modifieddate
            --############################################
            , cast(NAME as varchar) as category_name
            --############################################
            -- , cast(ROWGUID as varchar) as 
        from {{ source('erp_adventure_works', 'ProductCategory') }}
    )

select *
from source_product_category
