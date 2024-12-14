with 
    date_range as (
        select *
        from {{ ref('stg_erp__time') }}
        order by date asc
    )

select *
from date_range