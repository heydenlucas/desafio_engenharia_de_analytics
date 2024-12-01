with
    source_salesperson as (
        select 
            cast(BUSINESSENTITYID as int) as id_salesperson
            , cast(TERRITORYID as int) as id_territory
            , cast(MODIFIEDDATE as date) as salesperson_modifieddate
            --#################################################
            , cast(SALESQUOTA as int) as sales_goal
            , cast(COMMISSIONPCT as varchar) as comission_perc
            , cast(SALESYTD as numeric(18,4)) as accumulated_sales
            , cast(SALESLASTYEAR as numeric(18,4)) as last_year_sales
            --#################################################
            --, cast(ROWGUID as varchar) as
        from {{ source('erp_adventure_works', 'SalesPerson') }}
    )

select *
from source_salesperson