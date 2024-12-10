{{ config(materialized='table') }}

WITH tripadvisor__review__change_type AS (
    SELECT 
        CAST(location_id AS INTEGER) AS location_id
        , CAST(location_url AS STRING) AS location_url
        , CAST(location_address AS STRING) AS location_address
        , CAST(location_map AS STRING) AS location_map
        , CAST(latitude AS FLOAT64) AS latitude
        , CAST(longitude AS FLOAT64) AS longitude
        , CAST(price_range AS STRING) AS price_range
        , CAST(cuisine AS STRING) AS cuisine
        , CAST(location_rank AS FLOAT64) AS location_rank
        , CAST(location_overall_rate AS FLOAT64) AS location_overall_rate
        , CAST(review_count AS INTEGER) AS review_count
        , CAST(review_count_scraped AS INTEGER) AS review_count_scraped
        , CAST(location_rating AS FLOAT64) AS location_rating
        , FORMAT_DATE('%Y-%m', PARSE_DATE('%B %e, %Y', review_date)) AS review_date
        , CAST(review_type AS STRING) AS review_type
        , CAST(review_description AS STRING) AS review_description
        , CAST(review_title AS STRING) AS review_title
        , CAST(user AS STRING) AS user
    FROM {{ ref('stg_tripadvisor__review') }}
)

SELECT *
FROM tripadvisor__review__change_type