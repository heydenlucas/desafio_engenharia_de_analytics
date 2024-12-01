with 
    orderdetail as (
        select 
            PK_ORDER_DETAIL
            , FK_SALESORDER
            , FK_CUSTOMER
            , FK_SALES_PERSON
            , ORDER_QUANTITY
            , UNIT_PRICE
            , UNIT_PRICE_DESC
            , GROSS_SUBTOTAL
            , NET_SUBTOTAL
            , PRORATED_FREIGHT
            , PRORATED_TAX
        from {{ ref('int_orderdetails') }}
    )
    , salesperson as (
        select 
            ID_SALESPERSON
            , ID_TERRITORY
            , SALESPERSON_MODIFIEDDATE
            , SALES_GOAL
            , COMISSION_PERC
            , ACCUMULATED_SALES
            , LAST_YEAR_SALES
        from {{ ref('stg_erp__salesperson') }}
    )
    , person as (
        select 
            PK_PERSON
            , PERSON_MODIFIED_DATE
            , PERSON_TYPE
            , PERSON_NAME
        from {{ ref('stg_erp__person') }}
    )
    , sales_salesperson as (
        select --sum(ORDER_QUANTITY)
            FK_SALES_PERSON as ID_sales_salesperson
            , sum(ORDER_QUANTITY) as product_qty
            , count(FK_SALESORDER) as ORDER_Qty
            , count(distinct FK_CUSTOMER) as client_qty
            , cast(sum((UNIT_PRICE * ORDER_QUANTITY) * (1 - UNIT_PRICE_DESC)) as numeric(18,2))  as total_per_salesperson
            , cast(avg(NET_SUBTOTAL) as numeric(18,2)) as average_ticket
        from orderdetail
        -- where FK_SALES_PERSON = 285
        group by 
            ID_sales_salesperson
    )
    , joined as (
        select 
            prs.PK_PERSON
            , prs.PERSON_TYPE
            , prs.PERSON_NAME as sales_person
            , ssp.product_qty
            , ssp.ORDER_Qty
            , ssp.client_Qty
            -- , ssp.GROSS_SUBTOTAL
            , ssp.total_per_salesperson
            , sp.SALES_GOAL
            , sp.COMISSION_PERC
            , sp.ACCUMULATED_SALES
            , sp.LAST_YEAR_SALES
            , ssp.average_ticket
        from salesperson as sp
        left join sales_salesperson as ssp on ssp.ID_sales_salesperson = sp.ID_SALESPERSON
        left join person as prs on prs.PK_PERSON = sp.ID_SALESPERSON
    )

select *
from joined
order by sales_person
