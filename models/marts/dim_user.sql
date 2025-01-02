{{ config(materialized='table') }}

SELECT DISTINCT
    {{ hash_one_col('user') }} AS user_id
    , user
    , username
    , user_country
FROM {{ ref('intermediate_tripadvisor__review') }}
