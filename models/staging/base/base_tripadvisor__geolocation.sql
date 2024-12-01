{{ config(materialized='table') }}

WITH cte__geolocation__source_name AS (
    SELECT *
    FROM {{ ref('source_tripadvisor__geolocation') }}
)

, cte__geolocation__rename_column AS (
    SELECT
        district_name
        , district_codename AS district_code
        , ward_name
        , ward_codename AS ward_code
        , latitude
        , longitude
    FROM cte__geolocation__source_name
)

, cte__geolocation__change_type AS (
    SELECT
        CAST(district_name AS STRING) AS district_name
        , CAST(district_code AS STRING) AS district_code
        , CAST(ward_name AS STRING) AS ward_name
        , CAST(ward_code AS STRING) AS ward_code
        , CAST(latitude AS NUMERIC) AS latitude
        , CAST(longitude AS NUMERIC) AS longitude
    FROM cte__geolocation__rename_column
)

SELECT *
FROM cte__geolocation__change_type
