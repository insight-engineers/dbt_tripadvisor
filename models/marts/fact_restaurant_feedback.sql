{{ config(materialized='table') }}

SELECT
    location_id
    , {{ hash_two_cols('location_id', 'user') }} AS review_id
    , {{ hash_one_col('cuisine') }} AS cuisine_id
    , {{ hash_one_col('user') }} AS user_id
    , review_date
    , location_rank
    , location_overall_rate
    , review_count
    , review_count_scraped
    , price_range
    , price
FROM {{ ref('intermediate_tripadvisor__review') }}
