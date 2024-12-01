/*
This test validates the gross total of $12.646.112,16 that Carlos Silveira
(CEO of Adventure Workd) indicated is matching with the values of the
database.
*/

with    
    gross_total_2011 as (
        select 
            round(sum(GROSS_SUBTOTAL),2) as gross_total
        from {{ ref('int_orderdetails') }}
        where year(ORDER_DATE) = 2011
    )

select *
from gross_total_2011
where gross_total not between 12646112.15 and 12646112.17
