-- -##CREATE DIMENSION THAT STORES INFORMATION RELATED TO CURRENCY PER COUNTRY AND
-- EXCHANGE RATE ACCORDING TO DATETIME, IT ASUMES THE EXCHANGE RATES CAN CHANGE WITHIN
-- THE SAME DAY THROUGHOUT TIME ##---
{{ config(materialized="table") }}

with 
source as 
(
    select * from {{source("GLOBEPAY_ACCEPTANCE1","GLOBEPAY_ACCEPTANCE1")}}
),


    rates as (
        select
            external_ref,
            date_time,
            country,
            currency,
            case
                when currency = 'USD'
                then json_value(rates_json, '$.USD')
                when currency = 'MXN'
                then json_value(rates_json, '$.MXN')
                when currency = 'GBP'
                then json_value(rates_json, '$.GBP')
                when currency = 'EUR'
                then json_value(rates_json, '$.EUR')
                when currency = 'CAD'
                then json_value(rates_json, '$.CAD')
                else null
            end as exchange_rate
        from source
    )

select * from rates
