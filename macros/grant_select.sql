-- Note the built in jinja will not recognize the toles unless you youe a specific format in your .env file. 
-- doce here : https://docs.getdbt.com/reference/dbt-jinja-functions/env_var?version=1.12

{% macro grant_select (schema=target.schema, role=target.role) %}
    {% set sql%}
        grant usage on schema {{ schema }} to {{ role }}
        grant select on all tables in schema {{ schema }} to role {{ role }}
        grant select on all views in schema {{ schema }} to role {{ role }}
    {% endset %}

    {{ log('Granting select on all tables and views in schema ' ~ target.schema ~ ' to role ' ~ role, info=True) }}
    {% do run_query(sql) %}
    {{ log('Privileges granted', info=True) }}
{% endmacro %}