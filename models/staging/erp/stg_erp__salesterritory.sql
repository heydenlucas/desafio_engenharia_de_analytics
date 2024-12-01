with    
    source_salesterritory as (
        select 
            cast(TERRITORYID as int) as pk_territory
            , cast(MODIFIEDDATE as varchar) as territory_modifieddate
            , cast(NAME as varchar) as territory_name
            , cast(COUNTRYREGIONCODE as varchar) as country_code
            , cast(SALESYTD as numeric(18,4)) as accumulated_sales
            , cast(SALESLASTYEAR as numeric(18,4)) as last_year_sales
            --#######################################
            -- , cast(ROWGUID as varchar) as
            -- , cast(COSTYTD as varchar) as -- no values
            -- , cast(COSTLASTYEAR as varchar) as -- no values
            -- , group -- this name don't work
        from {{ source('erp_adventure_works', 'SalesTerritory') }}
    )

select *
from source_salesterritory