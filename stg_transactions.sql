with 
source as 
(
    select * from {{source("GLOBEPAY_ACCEPTANCE1","GLOBEPAY_ACCEPTANCE1")}}
),

transactions as 
(
    SELECT  external_ref,
            status, 
            source,
            ref,
            date_time, 
            EXTRACT (DAY FROM DATE_TIME) as DATE_CALC,
            EXTRACT (month FROM DATE_TIME) as month_CALC,
            EXTRACT (DAYOFWEEK FROM DATE_TIME) AS DAYOFWEEK_CALC,
            state,
            cvv_provided,
            AMOUNT
    FROM source
)
select * from transactions
