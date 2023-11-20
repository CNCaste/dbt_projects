----##THE ANALYTICAL BASE TABLE RESUMES ALL ATTRIBUTES AND FACTS RELEVANT FOR DATA ANALYSIS CONSUMPTION###---

{{ config (
    materialized="table"
)}}

with fact_transactions as (
    select * from {{ ref('fact_transactions')}}
),

    transactions as (
    select * from {{ ref('stg_transactions') }}
),


   abt_transactions AS (
    select
        fact_transactions.*,
        transactions.DATE_CALC,
        transactions.month_CALC,
        transactions.DAYOFWEEK_CALC,
        CASE WHEN fact_transactions.STATE='ACCEPTED' THEN fact_transactions.AMOUNT_USD END AS ACCEPTED_AMOUNT_USD,
        CASE WHEN fact_transactions.STATE='DECLINED' THEN fact_transactions.AMOUNT_USD END AS DECLINED_AMOUNT_USD
    FROM fact_transactions 
    LEFT JOIN transactions using (external_ref)
)
select * from abt_transactions 
