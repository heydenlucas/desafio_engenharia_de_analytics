with 
    source_creditcard as (
        select 
            cast(CREDITCARDID as int) as pK_CREDIT_CARD
            --##################################
            , cast(MODIFIEDDATE as date) as CreditCard_modifieddate
            --##################################
            , cast(CARDTYPE as varchar) as card_type
            , cast(CARDNUMBER as int) as card_number
            , cast(EXPMONTH as int) as card_exp_month
            , cast(EXPYEAR as int) as card_exp_year
            
        from {{ source('erp_adventure_works', 'CreditCard') }}
    )
    , source_person_creditcard as (
        select 
            cast(CREDITCARDID as int) as pK_CREDIT_CARD
            , cast(BUSINESSENTITYID as int) as fk_person
            , cast(MODIFIEDDATE as date) as person_creditcard_modifieddate
        from {{ source('erp_adventure_works', 'PersonCreditCard') }}
    )
    , joined as (
        select 
            source_creditcard.pK_CREDIT_CARD
            , source_person_creditcard.fk_person
            --###############################
            , source_creditcard.CreditCard_modifieddate
            , source_person_creditcard.person_creditcard_modifieddate as person_creditcard_modifieddate
            --###############################
            , source_creditcard.card_type
            , source_creditcard.card_number
            , source_creditcard.card_exp_month
            , source_creditcard.card_exp_year  
        from source_creditcard
        left join source_person_creditcard on source_person_creditcard.PK_CREDIT_CARD = source_creditcard.PK_CREDIT_CARD

    )

-- continuar à partir daqui fazendo um join entre essas duas tabelas e depois
-- fazendo um join desse output com o person no intermediate

select *
from joined