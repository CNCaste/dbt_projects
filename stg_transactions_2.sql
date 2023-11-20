----#CREATE A SECOND LAYER STAGING TABLE COMPILING FOR EACH TRANSACTION THE AMOUNTS ACCORDING TO THE TRANSACTION STATE###--
with transactions as (
    select * from {{ ref('stg_transactions')}}
),

rates as (
    select * from {{ ref('dim_rates') }}
),

  transactions_2 AS (
    select
    transactions.external_ref,
    transactions.ref,
    transactions.date_time,
    transactions.status,
    transactions.source,
    transactions.state,
    rates.COUNTRY,
    rates.CURRENCY,
    transactions.CVV_PROVIDED,
    (transactions.AMOUNT/PARSE_NUMERIC(rates.EXCHANGE_RATE)) AS AMOUNT_USD
    FROM transactions 
    LEFT JOIN rates  using(EXTERNAL_REF)

)

select * from transactions_2
