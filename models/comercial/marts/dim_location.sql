with 
    location as (
        select 
            PK_ADDRESS
            , CITY
            , ADDRESS
            , POSTAL_CODE
            , STATE_NAME
            , COUNTRY_NAME
            , FULL_ADDRESS
        from {{ ref('int_location') }}
    )
    , reordered as (
        select 
            PK_ADDRESS as PK_SHIP_TO_ADDRESS
            , CITY
            , STATE_NAME as STATE
            , COUNTRY_NAME as COUNTRY
            , POSTAL_CODE
            , FULL_ADDRESS      
        from location
    )

select *
from reordered