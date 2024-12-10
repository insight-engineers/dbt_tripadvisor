{% macro hash_one_col(column_name) %}
  CONCAT(
    SUBSTR(TO_HEX(MD5({{ column_name }})), 1, 8),
    "-", SUBSTR(TO_HEX(MD5({{ column_name }})), 9, 4),
    "-", SUBSTR(TO_HEX(MD5({{ column_name }})), 13, 4),
    "-", SUBSTR(TO_HEX(MD5({{ column_name }})), 17, 4),
    "-", SUBSTR(TO_HEX(MD5({{ column_name }})), 21, 12)
  )
{% endmacro %}
