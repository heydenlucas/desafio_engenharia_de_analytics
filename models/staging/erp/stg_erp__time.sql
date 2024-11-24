with
    orderdetails_date as (
        select 
            PK_ORDER_DETAIL
            , ORDER_DATE
        from {{ ref('int_orderdetails') }}
    )
    , month_mapping as (
        select *
        FROM (VALUES
            (1, 'January'),
            (2, 'February'),
            (3, 'March'),
            (4, 'April'),
            (5, 'May'),
            (6, 'June'),
            (7, 'July'),
            (8, 'August'),
            (9, 'September'),
            (10, 'October'),
            (11, 'November'),
            (12, 'December')
        ) AS month_mapping(month_number, month_name)
    )
    , date_separation as (
        select 
            orderdetails_date.ORDER_DATE
            , day(orderdetails_date.ORDER_DATE) as _day_
            , cast(month(orderdetails_date.ORDER_DATE) as int) as _month_
            , year(orderdetails_date.ORDER_DATE) as _year_
            --, monthname(ORDER_DATE) as month_name
            , month_mapping.month_name as month_name
            , EXTRACT(QUARTER FROM orderdetails_date.ORDER_DATE) AS quarter

        from orderdetails_date
        left join month_mapping on _month_ = month_mapping.month_number  
    )

select *
from date_separation