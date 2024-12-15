{{ config(materialized='table') }}

WITH dim_location__select AS (
    SELECT *
    FROM {{ ref("intermediate_tripadvisor__location") }}
)

, dim_location__addition_infomation AS (
    SELECT DISTINCT
        location_id
        , location_url
        , location_map
        , latitude
        , longitude
    FROM {{ ref('intermediate_tripadvisor__review') }}
)

SELECT
    location.*
    , location_url
    , location_map
    , latitude
    , longitude
FROM dim_location__select AS location
LEFT JOIN dim_location__addition_infomation
    ON location.location_id = dim_location__addition_infomation.location_id
