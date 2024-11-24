with 
    address as (
        select 
            PK_ADDRESS
            , FK_STATE
            , ADDRESS_MODIFIED_DATE
            , CITY
            , ADDRESS
            , POSTAL_CODE
        from {{ ref('stg_erp__address') }}
    )
    , state as (
        select 
            PK_STATE
            , FK_TERRITORY
            , FK_COUNTRY
            , STATE_MODIFIED_DATE
            , STATE_CODE
            , FLG_STATE_COUNTRY
            , STATE_NAME
        from {{ ref('stg_erp__state') }}
    )
    , country as (
        select 
            PK_COUNTRY
            , COUNTRY_MODIFIEDDATE
            , COUNTRY_NAME
        from {{ ref('stg_erp__country') }}
    )
    , joined as (
        select 
            address.PK_ADDRESS
            , address.CITY
            , address.ADDRESS
            , address.POSTAL_CODE
            , state.STATE_NAME
            , country.COUNTRY_NAME
            , ifnull(address.ADDRESS,'')
                ||ifnull(', '||address.CITY,'')
                ||ifnull(', '||state.STATE_CODE,'')
                ||ifnull(address.POSTAL_CODE,'')
                ||ifnull(', '||country.COUNTRY_NAME,'')
                as full_address
        from address
        left join state on state.pk_state = address.fk_state
        left join country on country.pk_country = state.fk_country
    )


select *
from joined