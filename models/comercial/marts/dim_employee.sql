with 
    employee as (
        select *
        from {{ ref('stg_erp__employee') }}
    )

select *
from employee
