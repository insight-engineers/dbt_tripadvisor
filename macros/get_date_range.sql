{% macro get_date_range(table_name, date_column_name) %}
    {% set min_date_query %}
        SELECT 
            MIN({{ date_column_name }}) AS min_date,
            MAX({{ date_column_name }}) AS max_date
        FROM {{ table_name }}
    {% endset %}

    {% set results = run_query(min_date_query) %}
    {% if results and results.rows|length > 0 %}
        {% set min_date = results.columns[0].values[0] %}
        {% set max_date = results.columns[1].values[0] %}
        {% if min_date and max_date %}
            {% do return({'min_date': min_date, 'max_date': max_date}) %}
        {% else %}
            {% do log("MIN or MAX date is NULL, falling back to default values.", info=True) %}
            {% do return({'max_date': "3000-01-01"}) %}
        {% endif %}
    {% else %}
        {% do log("No data found in the specified table or column.", info=True) %}
        {% do return({'max_date': "3000-01-01"}) %}
    {% endif %}
{% endmacro %}
