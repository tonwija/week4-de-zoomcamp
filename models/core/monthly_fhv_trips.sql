{{ config(materialized='table') }}

with fhv_trips_data as (
    select * from {{ ref('fhv_fact_trips') }}
)
    select 
    -- Reveneue grouping 
    date_trunc(pickup_datetime, month) as revenue_month, 
    --Note: For BQ use instead: date_trunc(pickup_datetime, month) as revenue_month, 
    -- Additional calculations
    count(tripid) as total_monthly_trips,
    from fhv_trips_data
    group by 1