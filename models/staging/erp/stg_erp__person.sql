with 
    source_person as(
        select 
            cast(BUSINESSENTITYID as int) as id_person_entity
            --########################################
            , cast(MODIFIEDDATE as date) as person_modified_date
            --########################################
            --, cast(PERSONTYPE as varchar) as person_type
            , case 
              when persontype = 'SC' then 'Store' 
                when persontype = 'IN' then 'Customer'
                when persontype = 'SP' then 'Sales Person'
                when persontype = 'EM' then 'Employee'
                when persontype = 'VC' then 'Fornecedor'
                when persontype = 'GC' then 'Contato Geral'
                else null
                end as person_type
            , concat(
                ifnull(concat(cast(FIRSTNAME as varchar),' '),'')
                ,ifnull(concat(cast(MIDDLENAME as varchar),' '),'')
                ,ifnull(cast(LASTNAME as varchar),'')
              ) as person_name      
            --###################################################
            --, cast(SUFFIX as varchar) as
            -- sufixo de vocativo (não será necessário)
            --, cast(ADDITIONALCONTACTINFO as varchar) as
            -- informações para cntato adicional (não serão necessárias)
            --, cast(DEMOGRAPHICS as varchar) as
            -- dados demográficos (não serão necessários)
            -- , cast(ROWGUID as varchar) as
            -- não categorizado (não serão necessários)
            -- , cast(FIRSTNAME as varchar) as person_firstname
            -- , cast(MIDDLENAME as varchar)  person_middlename
            -- , cast(LASTNAME as varchar) as person_lastname
            -- foram usadas como nome completo
            -- , cast(NAMESTYLE as boolean) as person_name_style
            -- não categorizado (não serão necessários)
            -- , cast(TITLE as varchar) as person_title
            -- vocativo (não serão necessários)
            -- , cast(EMAILPROMOTION as int) as person_email_count
            -- vocativo (não serão necessários)
        from {{ source('erp_adventure_works', 'Person') }}
    )

select *
from source_person
-- where pk_person = 15693
