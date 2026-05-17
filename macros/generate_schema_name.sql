{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

        {#

        old name
        {{ default_schema }}_{{ custom_schema_name | trim }}
            
        new custom schema
        #}

        {{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}


{#
So even when you override the custom schema it is possible for you to not write to the schema that you initially wanted to access
espectially when you are pointing to a specific target environment. The way it usually writes to the database it adds a custom 
schema name AFTER the default schema to keep different team members code separate.

If you want to override the behavior you need to create a macros to override the default behavior like above.
#}