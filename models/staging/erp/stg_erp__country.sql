with
     source_country as (
        select 
            cast(COUNTRYREGIONCODE as varchar) as pk_country
            , cast(MODIFIEDDATE as date) as country_modifieddate
            , cast(NAME as varchar) as country_name            
        from {{ source('erp_adventure_works', 'CountryRegion') }}
    )

select *
from source_country

-- select count(distinct(COUNTRYREGIONCODE))
--         , count(COUNTRYREGIONCODE)
-- from {{ source('erp_adventure_works', 'CountryRegion') }}
