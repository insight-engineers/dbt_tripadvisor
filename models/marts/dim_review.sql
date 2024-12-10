{{ config(materialized='table') }}

SELECT DISTINCT
    {{ hash_two_cols('location_id', 'user') }} AS review_id
    , review_date
    , review_type
    , review_title
    , review_description
    , location_rating
FROM {{ ref('intermediate_tripadvisor__review') }}