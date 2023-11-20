---##CREATE THE DIM TABLE CONTAINING INFORMATION RELATED TO THE CHARGEBACKS AND ITS STATUS##----
{{ config (
    materialized="table"
)}}

with 
source as 
(
    select * from {{source("GLOBEPAY_CHARGEBACK","GLOBEPAY_CHARGEBACK")}}
),

 chargeback as
(
    SELECT  external_ref,
            status,
            source,
            chargeback
    FROM source
)

select * from chargeback
