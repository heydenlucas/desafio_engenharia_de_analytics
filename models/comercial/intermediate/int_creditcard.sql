
with creditcard as (
        select
            pK_CREDIT_CARD
            --#################################
            , CreditCard_modifieddate
            --#################################
            , card_type
            , card_number
            , card_exp_month
            , card_exp_year
        from {{ ref('stg_erp__creditcard') }}
    )

select *
from creditcard
