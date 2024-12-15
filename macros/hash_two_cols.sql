{% macro hash_two_cols(column1, column2) %}
  CONCAT(
    SUBSTR(TO_HEX(MD5(CONCAT(CAST({{ column1 }} AS STRING), '_', CAST({{ column2 }} AS STRING)))), 1, 8),
    "-", SUBSTR(TO_HEX(MD5(CONCAT(CAST({{ column1 }} AS STRING), '_', CAST({{ column2 }} AS STRING)))), 9, 4),
    "-", SUBSTR(TO_HEX(MD5(CONCAT(CAST({{ column1 }} AS STRING), '_', CAST({{ column2 }} AS STRING)))), 13, 4),
    "-", SUBSTR(TO_HEX(MD5(CONCAT(CAST({{ column1 }} AS STRING), '_', CAST({{ column2 }} AS STRING)))), 17, 4),
    "-", SUBSTR(TO_HEX(MD5(CONCAT(CAST({{ column1 }} AS STRING), '_', CAST({{ column2 }} AS STRING)))), 21, 12)
  )
{% endmacro %}
