{{ config(materialized='table') }}

with fhv_data as (
    select * 
    from {{ ref('stg_fhv_tripdata') }}
)
select *
from fhv_data