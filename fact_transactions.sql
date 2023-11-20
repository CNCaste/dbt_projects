----#CREATE A FACT TABLE COMPILING FOR EACH TRANSACTION THE AMOUNTS ACCORDING TO THE TRANSACTION STATE AND ADDING THE CHARGEBACK###--

{{ config (
    materialized="table"
)}}

with transactions_2 as (
    select * from {{ ref('stg_transactions_2')}}
),

    chargeback as (
    select * from {{ ref('dim_chargeback') }}
),


  fact_transactions AS (
    select
    transactions_2.*,
    chargeback.chargeback
    FROM transactions_2 
    LEFT JOIN chargeback  using(EXTERNAL_REF)

)
select * from fact_transactions
