with 
    client as (
        select 
            PK_CLIENT
            , FK_PERSON
            , FK_STORE
            , FK_TERRITORY
        from {{ ref('stg_erp__customer') }}
    )
    , person as (
        select 
            PK_PERSON
            , PERSON_TYPE
            , PERSON_NAME
        from {{ ref('stg_erp__person') }}
    )
    , Store as (
        select 
            PK_STORE
            , FK_SALES_PERSON
            , STORE_MODIFIED_DATE
            , STORE_NAME
        from {{ ref('stg_erp__store') }}
    )

    , joined as (
            select
                {{ dbt_utils.generate_surrogate_key(['PK_CLIENT']) }} as sk_client
                , client.pk_client
                , client.FK_PERSON
                , client.FK_STORE
                , client.FK_TERRITORY
                , person.person_name
                , person.PERSON_TYPE
                , store.STORE_NAme

            from client
            left join person on person.pk_person = client.fk_person
            left join store on store.pk_store = client.FK_STORE
    )

select *
from joined



