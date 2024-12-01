{{ config(materialized='table') }}

WITH cte__geolocation__source_name AS (
    SELECT *
    FROM {{ ref('source_tripadvisor__geolocation') }}
)

, cte__geolocation__rename_column AS (
    SELECT 
        district_name 
        ,district_codename AS district_code 
        ,ward_name
        ,ward_codename AS ward_code 
        ,latitude
        ,longitude
    FROM cte__geolocation__source_name
)

, cte__geolocation__change_type AS (
    SELECT 
        CAST(district_name AS STRING) district_name
        ,CAST(district_code AS STRING) district_code
        ,CAST(ward_name AS STRING) ward_name
        ,CAST(ward_code AS STRING) ward_code
        ,CAST(latitude AS NUMERIC) latitude
        ,CAST(longitude AS NUMERIC) longitude
    FROM cte__geolocation__rename_column
)

SELECT *
FROM cte__geolocation__change_type