with
    product as (
        select
            pk_product,
            pk_pd_number,
            fk_subcategory,
            fk_model,
            product_modifieddate,
            pruduct_start_sell_dt,
            pruduct_end_sell_dt,
            product_name
        from {{ ref("stg_erp__product") }}
    ),
    product_subcategory as (
        select
            pk_product_subcategory,
            fk_product_category,
            subcategory_modifieddate,
            subcategory_name
        from {{ ref("stg_erp__product_subcategory") }}
    ),
    product_category as (
        select pk_product_category, category_modifieddate, category_name
        from {{ ref("stg_erp__product_category") }}
    ),
    joined as (
        select
            product.pk_product,
            product.pk_pd_number,
            product.fk_subcategory,
            product.fk_model,
            -- ###############################
            product.product_modifieddate,
            product_category.category_modifieddate,
            product_subcategory.subcategory_modifieddate,
            product.pruduct_start_sell_dt,
            product.pruduct_end_sell_dt,
            product.product_name,
            -- ###############################            
            product_category.category_name,
            product_subcategory.subcategory_name
        from product
        left join
            product_subcategory
            on product_subcategory.pk_product_subcategory = product.fk_subcategory
        left join
            product_category
            on product_category.pk_product_category
            = product_subcategory.fk_product_category

    )

select *
from joined
