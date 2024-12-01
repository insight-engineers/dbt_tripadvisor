WITH cte__tripadvisor_queries AS (
    SELECT query
    FROM {{ ref('seed_tripadvisor__queries') }}
)

-- Add an ID to the queries
, cte__tripadvisor_queries__with_id AS (
    SELECT
        ROW_NUMBER() OVER () AS id
        -- Normalize the text (lowercase, remove spaces, etc.)
        , LOWER(REGEXP_REPLACE(query, '[^a-zA-Z0-9]', '_')) AS query
    FROM cte__tripadvisor_queries
)

-- Return the queries with their IDs
SELECT
    cte.id
    , cte.query
FROM cte__tripadvisor_queries__with_id AS cte
ORDER BY cte.id
