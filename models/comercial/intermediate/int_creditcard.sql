with
    creditcard as (
        select
            PK_CREDIT_CARD
            , fK_PERSON
            , CREDITCARD_MODIFIEDDATE
            , PERSON_CREDITCARD_MODIFIEDDATE
            , CARD_TYPE
            , CARD_NUMBER
            , CARD_EXP_MONTH
            , CARD_EXP_YEAR
        from {{ ref('stg_erp__creditcard') }}
    )
    , person as (
        select
            PK_PERSON
            , PERSON_MODIFIED_DATE
            , PERSON_TYPE
            , PERSON_NAME
        from {{ ref('stg_erp__person') }}
    )
    , joined as (
        select 
            {{ dbt_utils.generate_surrogate_key(['creditcard.PK_CREDIT_CARD']) }} as sk_creditcard
            , creditcard.PK_CREDIT_CARD
            , creditcard.fK_PERSON
            , creditcard.CREDITCARD_MODIFIEDDATE
            , creditcard.PERSON_CREDITCARD_MODIFIEDDATE
            , creditcard.CARD_TYPE
            , creditcard.CARD_NUMBER
            , creditcard.CARD_EXP_MONTH
            , creditcard.CARD_EXP_YEAR
            --, person.PK_PERSON
            , person.PERSON_MODIFIED_DATE
            , person.PERSON_TYPE
            , person.PERSON_NAME
        from creditcard
        left join person on person.PK_PERSON = creditcard.fk_person
    )

select *
from joined