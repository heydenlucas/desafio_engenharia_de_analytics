with
    salesreason as (
        select *
        from {{ ref('int_salesreason') }}
    )

select *
from salesreason