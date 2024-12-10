{{ config(materialized='table') }}

WITH tripadvisor__location__change_type AS (
    SELECT 
        CAST(location_id AS INTEGER) location_id
        , CAST(location_name AS STRING) location_name 
        , CAST(distance AS FLOAT64) distance
        , CAST(address AS STRING) address
        , CAST(city AS STRING) city
        , CAST(country AS STRING) country
        , CAST(street1 AS STRING) street1
        , CAST(street2 AS STRING) street2
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
        , ROW_NUMBER() OVER(PARTITION BY location_id ORDER BY distance ASC) row_num
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

SELECT *
FROM tripadvisor__location__deduplicated