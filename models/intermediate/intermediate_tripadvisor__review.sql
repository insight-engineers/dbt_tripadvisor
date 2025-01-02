{{ config(materialized='table') }}

WITH tripadvisor__review__handle_special_values AS (
    SELECT
        location_id
        , location_url
        , location_address
        , location_map
        , latitude
        , longitude
        , phone_number
        , open_hour
        , price_range
        , c.element.element AS cuisine
        , location_rank
        , location_overall_rate
        , review_count
        , review_count_scraped
        , r.element.rating AS review_rating
        , r.element.review_type
        , r.element.text AS location_description
        , r.element.title AS review_title
        , r.element.user
        , r.element.username
        , r.element.country AS user_country
        , FORMAT_DATE('%Y-%m-%d', PARSE_DATE('%B %e, %Y', r.element.review_date)) AS review_date
    FROM {{ ref('stg_tripadvisor__review') }}
    LEFT JOIN UNNEST(cuisine_array) AS c
    LEFT JOIN UNNEST(review_array) AS r
)

, tripadvisor__review__change_type AS (
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
        , CAST(review_rating AS FLOAT64) AS review_rating
        , CAST(review_date AS DATE) AS review_date
        , CAST(review_type AS STRING) AS review_type
        , CAST(location_description AS STRING) AS review_description
        , CAST(review_title AS STRING) AS review_title
        , CAST(user AS STRING) AS user
        , CAST(username AS STRING) AS username
        , CAST(user_country AS STRING) AS user_country
    FROM tripadvisor__review__handle_special_values
)

, tripadvisor__review__handle_null_value AS (
    SELECT
        COALESCE(location_id, -1) AS location_id
        , COALESCE(location_url, 'Not Defined') AS location_url
        , COALESCE(location_address, 'Not Defined') AS location_address
        , COALESCE(location_map, 'Not Defined') AS location_map
        , COALESCE(latitude, -1) AS latitude
        , COALESCE(longitude, -1) AS longitude
        , CASE
            WHEN price_range = '$' THEN 'Cheap Eats'
            WHEN price_range = '$$ - $$$' THEN 'Mid-range'
            WHEN price_range = '$$$$' THEN 'Fine Dining'
            WHEN price_range IS null THEN 'Not Defined'
            ELSE 'Unknown'
        END AS price
        , COALESCE(price_range, 'Not Defined') AS price_range
        , COALESCE(cuisine, 'Not Defined') AS cuisine
        , COALESCE(location_rank, -1) AS location_rank
        , COALESCE(location_overall_rate, -1) AS location_overall_rate
        , COALESCE(review_count, -1) AS review_count
        , COALESCE(review_count_scraped, -1) AS review_count_scraped
        , COALESCE(review_rating, -1) AS review_rating
        , COALESCE(review_date, '3000-01-01') AS review_date
        , COALESCE(review_type, 'Not Defined') AS review_type
        , COALESCE(review_description, 'Not Defined') AS review_description
        , COALESCE(review_title, 'Not Defined') AS review_title
        , COALESCE(user, 'Not Defined') AS user
        , COALESCE(username, 'Not Defined') AS username
        , COALESCE(user_country, 'Not Defined') AS user_country
    FROM tripadvisor__review__change_type
)

SELECT *
FROM tripadvisor__review__handle_null_value
