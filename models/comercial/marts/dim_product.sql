with
    product as (
        select *
        from {{ ref('int_product') }}
    )
    
select *
from product