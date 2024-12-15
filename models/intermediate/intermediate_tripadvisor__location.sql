{{ config(materialized='table') }}

WITH tripadvisor__location__change_type AS (
    SELECT
        CAST(location_id AS INTEGER) AS location_id
        , CAST(location_name AS STRING) AS location_name
        , CAST(distance AS FLOAT64) AS distance
        , CAST(address AS STRING) AS address
        , CAST(city AS STRING) AS city
        , CAST(country AS STRING) AS country
        , CAST(street1 AS STRING) AS street1
        , CAST(street2 AS STRING) AS street2
    FROM {{ ref("stg_tripadvisor__location") }}
)

, tripadvisor__location__remove_another_city AS (
    SELECT *
    FROM tripadvisor__location__change_type
    WHERE city IN ("Ho Chi Minh City", "Di An")
)

, tripadvisor__location__ranked AS (
    SELECT
        *
        , ROW_NUMBER() OVER (PARTITION BY location_id ORDER BY distance ASC) AS row_num
    FROM tripadvisor__location__remove_another_city
)

, tripadvisor__location__deduplicated AS (
    SELECT
        location_id
        , location_name
        , address
        , city
        , country
        , street1
        , street2
    FROM tripadvisor__location__ranked
    WHERE row_num = 1
)

, tripadvisor__location__handle_null_values AS (
    SELECT
        COALESCE(location_id, -1) AS location_id
        , COALESCE(location_name, "Not Defined") AS location_name
        , COALESCE(address, "Not Defined") AS address
        , COALESCE(city, "Not Definec") AS city
        , COALESCE(country, "Not Defined") AS country
        , COALESCE(street1, "Not Defined") AS street1
        , COALESCE(street2, "Not Defined") AS street2
    FROM tripadvisor__location__deduplicated

)

SELECT *
FROM tripadvisor__location__handle_null_values
