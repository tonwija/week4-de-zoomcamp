{{ config(materialized='view') }}

select
{{ dbt_utils.surrogate_key(['dispatching_base_num', 'pickup_datetime']) }} as tripid, 
fhv_trips.dispatching_base_num as dispatching_base_num,
fhv_trips.pickup_datetime as pickup_datetime,
fhv_trips.dropoff_datetime as dropoff_datetime,
fhv_trips.PUlocationid as PUlocationid,
fhv_trips.DOLocationid as DOLocationid
from {{ source('staging','fhv_trips') }}

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}