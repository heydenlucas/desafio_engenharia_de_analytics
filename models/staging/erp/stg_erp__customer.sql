with
    source_customer as (
        select 
            cast(CUSTOMERID as int) as pk_client
            , cast(PERSONID as varchar) as fk_person
            , cast(STOREID as varchar) as fk_store
            , cast(TERRITORYID as varchar) as fk_territory
            --, cast(ROWGUID as varchar) as
            , cast(MODIFIEDDATE as date) as modified_date

        from {{ source('erp_adventure_works', 'Customer') }}
    )

select *
from source_customer
-- where fk_person <> ''
-- and fk_store <> ''

        -- select *
            
        -- from {{ source('erp_adventure_works', 'Customer') }}
