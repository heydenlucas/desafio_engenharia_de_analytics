with
    source_personprovince as (
        select 
        cast(STATEPROVINCEID as int) as pk_state
        --#############################################
        , cast(TERRITORYID as varchar) as fk_country
        --#############################################
        , cast(MODIFIEDDATE as date) as state_modified_date
        --#############################################
        , cast(STATEPROVINCECODE as varchar) as state_code
        , cast(NAME as varchar) as state_name
        , cast(COUNTRYREGIONCODE as varchar) as country_code
        , cast(ISONLYSTATEPROVINCEFLAG as varchar) as flag_state_country
        --####################################################
        -- , cast(ROWGUID as varchar) as
        -- não categorizado (não serão necessários)
        
        from {{ source('erp_adventure_works', 'StateProvince') }}
    )

select *
from source_personprovince

-- select 
--     count(TERRITORYID) as normall
--     , count(distinct(TERRITORYID)) as distinto
-- from {{ source('erp_adventure_works', 'StateProvince') }}