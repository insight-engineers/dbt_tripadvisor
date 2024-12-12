{{ config(materialized='table') }}

WITH tripadvisor__review__source_name AS (
    SELECT *
    FROM {{ source('raw_tripadvisor', 'source_tripadvisor__scrape_info') }}
)

, tripadvisor__review__rename_column AS (
    SELECT 
        location_id
        , location_url
        , address_from_url AS location_address
        , google_maps_link AS location_map
        , lat AS latitude
        , long AS longitude
        , tel AS phone_number
        , open_hour AS open_hour
        , price_range 
        , cuisine.list AS cuisine_array
        , ranking AS location_rank
        , rating AS location_overall_rate
        , review_count 
        , review_count_scraped
        , reviews.list AS review_array
    FROM tripadvisor__review__source_name
)

SELECT *
FROM tripadvisor__review__rename_column