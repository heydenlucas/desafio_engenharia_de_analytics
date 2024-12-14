with
    source_salesorderdetail as (
        select 
            cast(SALESORDERDETAILID as int) as pk_order_detail
            , cast(SALESORDERID as int) as fk_salesorder
            , cast(PRODUCTID as int) as fk_product
            , cast(SPECIALOFFERID as int) as fk_special_offer
            , cast(CARRIERTRACKINGNUMBER as varchar) as fk_traking_number
            --########################################
            , cast(MODIFIEDDATE as date) as modified_date
            --########################################
            , cast(ORDERQTY as int) as order_quantity         
            , cast(UNITPRICE as numeric(18,6)) as unit_price
            , cast(UNITPRICEDISCOUNT as numeric(18,6)) as unit_price_desc
            --###########################################
            --, cast(ROWGUID as varchar) as
        from {{ source('erp_adventure_works', 'SalesOrderDetail') }}
    )

select *
from source_salesorderdetail
-- where fk_salesorder = 62703