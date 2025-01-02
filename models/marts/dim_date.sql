WITH get_min_max_date AS (
    SELECT
        MIN(review_date) AS min_date
        , MAX(review_date) AS max_date
    FROM {{ ref('intermediate_tripadvisor__review') }}
    WHERE review_date != '3000-01-01'
)

SELECT
    FORMAT_DATE('%F', d) AS date
    , FORMAT_DATE('%A', d) AS day_of_week
    , FORMAT_DATE('%a', d) AS day_of_week_short
    , CASE
        WHEN FORMAT_DATE('%A', d) IN ('Sunday', 'Saturday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS is_weekday_or_weekend
    , DATE_TRUNC(d, MONTH) AS year_month
    , FORMAT_DATE('%B', d) AS month
    , DATE_TRUNC(d, YEAR) AS year
    , EXTRACT(YEAR FROM d) AS year_number
FROM (
    SELECT *
    FROM
        UNNEST(
            GENERATE_DATE_ARRAY(
                (SELECT min_date FROM get_min_max_date)
                , (SELECT max_date FROM get_min_max_date)
                , INTERVAL 1 DAY
            )
        ) AS d
    UNION ALL
    SELECT DATE('3000-01-01') AS d
)
