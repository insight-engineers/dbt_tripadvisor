{{ config(materialized='table') }}

WITH tripadvisor__location__source_name AS (
    SELECT *
    FROM {{ source('raw_tripadvisor', 'source_tripadvisor__api_info') }}
)

, tripadvisor__location__rename_column AS ( 
    SELECT
        location_id 
        , name AS location_name 
        , distance
        , address_obj.address_string AS address
        , address_obj.city AS city
        , address_obj.country AS country
        , address_obj.street1 AS street1
        , address_obj.street2 AS street2
    FROM tripadvisor__location__source_name
)

SELECT *
FROM tripadvisor__location__rename_column