with 
    employee as (
        select
            cast(BUSINESSENTITYID as int) as pk_store
            , cast(JOBTITLE as varchar) as employee_job_title
            , cast(GENDER as varchar) as employee_gender
            , cast(HIREDATE as varchar) as employee_hire_date
            --###############################################
            -- , cast(NATIONALIDNUMBER as varchar) as  
            --, cast(LOGINID as varchar) as 
            -- , cast(BIRTHDATE as varchar) as 
            -- , cast(MARITALSTATUS as varchar) as
            -- , cast(SALARIEDFLAG as varchar) as 
            -- , cast(VACATIONHOURS as varchar) as 
            -- , cast(SICKLEAVEHOURS as varchar) as 
            -- , cast(CURRENTFLAG as varchar) as 
            -- , cast(ROWGUID as varchar) as 
            -- , cast(MODIFIEDDATE as varchar) as 
            -- , cast(ORGANIZATIONNODE as varchar) as 
        from {{ source('erp_adventure_works', 'Employee') }}
    )
    , employee_department_history as (
        select 
            cast(DEPARTMENTID as varchar) as fk_department
            , cast(BUSINESSENTITYID as varchar) as fk_store
            , cast(SHIFTID as varchar) as fk_shift
            , cast(MODIFIEDDATE as date) as most_recent_date
            --##################################
            -- , cast(STARTDATE as varchar) as
            -- , cast(ENDDATE as varchar) as
            -- , cast(MODIFIEDDATE as varchar) as
        from {{ source('erp_adventure_works', 'EmployeeDepartmentHistory') }}
        order by most_recent_date
    )
    , shift as (
        select 
            cast(SHIFTID as varchar) as pk_shift
            , cast(NAME as varchar) as SHIFT
            -- , cast(STARTTIME as date) as
            -- , cast(ENDTIME as date) as
            -- , cast(MODIFIEDDATE as date) as
        from {{ source('erp_adventure_works', 'Shift') }}
    )
    , joined as (
        select
            ROW_NUMBER() OVER (PARTITION BY employee.PK_STORE
                                 ORDER BY employee_department_history.MOST_RECENT_DATE DESC) 
                                 AS rn
            , employee.PK_STORE
            , employee_department_history.most_recent_date
            --############################################
            -- , employee.pk_store
            , employee.employee_job_title
            , case
                when employee.employee_gender = 'M' then 'Male'
                when employee.employee_gender = 'F' then 'Female'
                ELSE employee.employee_gender
              end as gender
            , employee.employee_hire_date
            --############################################
            -- , shift.pk_shift
            , shift.SHIFT

        from employee_department_history
        left join employee on employee.pk_store = employee_department_history.fk_store
        left join shift on shift.pk_shift = employee_department_history.fk_shift
        order by employee_department_history.most_recent_date desc

    )
    , final_filtered as (
        select 
            PK_STORE
            , EMPLOYEE_JOB_TITLE
            , GENDER
            , EMPLOYEE_HIRE_DATE
            , SHIFT
        from joined
        where rn = 1
    )

select *
from final_filtered