{{ config(materialized='table') }}

SELECT DISTINCT
    {{ hash_one_col('user') }} as user_id
    , user AS user_name
FROM {{ ref('intermediate_tripadvisor__review') }}