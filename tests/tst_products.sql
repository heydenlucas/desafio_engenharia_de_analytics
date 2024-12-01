/*
This test validates the most than 500 distinct products of
 Adventure Works.
*/

with    
    products_500 as (
        select 
            count(pk_product) as total_products
        from {{ ref('int_product') }}
    )

select *
from products_500
where total_products <= 500


