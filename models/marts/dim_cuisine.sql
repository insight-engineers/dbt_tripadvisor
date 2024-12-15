{{ config(materialized='table') }}

SELECT DISTINCT
    {{ hash_one_col('cuisine') }} as cuisine_id
    , cuisine AS cuisine_name
FROM {{ ref('intermediate_tripadvisor__review') }}