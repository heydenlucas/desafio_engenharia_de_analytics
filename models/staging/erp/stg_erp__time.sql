with
    -- orderdetails_date as (
    --     select 
    --         PK_ORDER_DETAIL
    --         , ORDER_DATE
    --     from {{ ref('int_orderdetails') }}
    -- )
    range_of_dates as (
        select
            seq4() as d_offset,
            dateadd(day, seq4(), '2011-01-01'::date) as date
        from table(generator(rowcount => 1461)) 
        --  1461 dias -> 01/01/2011 a 01/01/2015
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

    , date_separation_v2 as (
        select 
            ROW_NUMBER() OVER (PARTITION BY range_of_dates.date ORDER BY range_of_dates.date) AS rn
            , range_of_dates.date
            , DATE_TRUNC('month', range_of_dates.date) as normalized_date
            , day(range_of_dates.date) as _day_
            , cast(month(range_of_dates.date) as int) as _month_
            , year(range_of_dates.date) as _year_
            --, monthname(date) as month_name
            , month_mapping.month_name as month_name
            , EXTRACT(QUARTER FROM range_of_dates.date) AS quarter

        from range_of_dates
        left join month_mapping on _month_ = month_mapping.month_number  
    )


    -- , date_separation as (
    --     select 
    --         ROW_NUMBER() OVER (PARTITION BY orderdetails_date.ORDER_DATE ORDER BY orderdetails_date.ORDER_DATE) AS rn
    --         , orderdetails_date.ORDER_DATE
    --         , day(orderdetails_date.ORDER_DATE) as _day_
    --         , cast(month(orderdetails_date.ORDER_DATE) as int) as _month_
    --         , year(orderdetails_date.ORDER_DATE) as _year_
    --         --, monthname(ORDER_DATE) as month_name
    --         , month_mapping.month_name as month_name
    --         , EXTRACT(QUARTER FROM orderdetails_date.ORDER_DATE) AS quarter

    --     from orderdetails_date
    --     left join month_mapping on _month_ = month_mapping.month_number  
    -- )
--     , unique_date as (
--         select 
--             ORDER_DATE
--             , DATE_TRUNC('month', ORDER_DATE)norm_oerder_date
--             , _day_
--             , _month_
--             , _year_
--             , month_name
--             , quarter
--         from date_separation
--         where rn = 1
--     )
-- select 
--     min(ORDER_DATE) as minimo
--     , max(ORDER_DATE) as maximo
-- from orderdetails_date


-- select distinct(rn)
-- from date_separation_v2


select *
from date_separation_v2





