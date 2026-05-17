{% macro template_example(args) %}

    {% set query%}
        select true as boolean
    {% endset %}

    {% if execute %}
        {% set results = run-query(query).columns[0].values()[0]%}
        {{log('SQL results ' ~ results, info=true)}}

        select {{ results }} as_is_real
        from a_real_table
    {% endexecute %}
{% endmacro %}


{#
execute variable documentation here:
https://docs.getdbt.com/reference/dbt-jinja-functions/execute

agate documentation here:
https://agate.readthedocs.io/en/latest/api/table.html

get_relations_by_prefix documentation:
https://github.com/dbt-labs/dbt-utils#get_relations_by_prefix-source


#}