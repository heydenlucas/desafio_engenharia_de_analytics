with 
    creditcard as (
        select *
        from {{ ref('int_creditcard') }}
    )

select *
from creditcard