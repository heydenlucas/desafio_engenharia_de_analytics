with
     source_address as (
        select 
            cast(ADDRESSID as int) as pk_address
            , cast(STATEPROVINCEID as int) as fk_state
            --##########################################
            , cast(MODIFIEDDATE as date) as address_modified_date
            --##########################################
            , cast(CITY as varchar) as city
            , ifnull(cast(ADDRESSLINE1 as varchar),'')||' '||ifnull(cast(ADDRESSLINE2 as varchar),'') as address
            , cast(POSTALCODE as varchar) as postal_code 
            --##########################################
            -- , cast(ROWGUID as varchar) as
            -- , cast(SPATIALLOCATION as varchar) as
            -- , ADDRESSLINE1
            -- this is the address
            -- , ADDRESSLINE2
            -- this is the complement
        from {{ source('erp_adventure_works', 'Address') }}
    )

select *
from source_address
