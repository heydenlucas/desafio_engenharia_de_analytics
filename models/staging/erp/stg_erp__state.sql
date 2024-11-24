with
     source_state as (
        select 
            cast(STATEPROVINCEID as int) as pk_state
            , cast(TERRITORYID as int) as fk_territory
            , cast(COUNTRYREGIONCODE as varchar) as fk_country
            --########################################      
            , cast(MODIFIEDDATE as date) as state_modified_date
            --########################################      
            , cast(STATEPROVINCECODE as varchar) as state_code
            , cast(ISONLYSTATEPROVINCEFLAG as boolean) as flg_state_country
            , cast(NAME as varchar) as state_name
            --########################################
            --, cast(ROWGUID as varchar) as 
            
        from {{ source('erp_adventure_works', 'StateProvince') }}
    )

select *
from source_state
