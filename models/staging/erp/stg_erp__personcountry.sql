with
    source_personcountry as (
        select 
            cast(COUNTRYREGIONCODE as varchar) as pk_country
            --######################################
            , cast(MODIFIEDDATE as date) as country_modified_date
            --######################################
            , cast(NAME as varchar) as country_name
        from {{ source('erp_adventure_works', 'CountryRegion') }}
    )


select *
from source_personcountry