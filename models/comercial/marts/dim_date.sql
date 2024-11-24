with 
    date_range as (
        select *
        from {{ ref('stg_erp__time') }}
        order by ORDER_DATE asc
    )

select *
from date_range