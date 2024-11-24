with
    source_store as (
        select 
            cast(BUSINESSENTITYID as int) as pk_store
            , cast(SALESPERSONID as int) as fk_sales_person
            --########################################
            , cast(MODIFIEDDATE as date) as store_modified_date
            --########################################
            , cast(NAME as varchar) as store_name
            --########################################
            --, cast(ROWGUID as varchar) as
            --, cast(DEMOGRAPHICS as varchar) as
        from {{ source('erp_adventure_works', 'Store') }}
    )

select *
from source_store