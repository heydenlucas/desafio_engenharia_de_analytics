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

    , joined as (
            select
                {{ dbt_utils.generate_surrogate_key(['PK_CLIENT']) }} as sk_cliente
                , client.pk_client
                , person.person_name

            from client
            left join person on person.pk_person = client.fk_person
    )

select *
from joined


