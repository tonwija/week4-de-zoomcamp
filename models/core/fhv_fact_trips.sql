{{ config(materialized='table') }}

with fhv_data as (
    select * 
    from {{ ref('stg_fhv_tripdata') }}
), 

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    fhv_data.tripid as tripid,
    fhv_data.dispatching_base_num as dispatching_base_num,
    fhv_data.pickup_datetime as pickup_datetime,
    fhv_data.dropoff_datetime as dropoff_datetime,
    pickup_zone.borough as pickup_zone,
    dropoff_zone.borough as dropoff_zone
from fhv_data
inner join dim_zones as pickup_zone
on fhv_data.PUlocationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_data.DOlocationid = dropoff_zone.locationid