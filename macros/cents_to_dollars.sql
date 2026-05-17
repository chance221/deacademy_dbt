{%- macro cents_to_dollars(column_name, decimals=2)-%}
    ROUND({{ column_name }} / 100, {{ decimals }})
{%- endmacro -%}

{#

When creating a macro create a doc for it. In the _macro_docs.yml file 
You can add comments as to what the macro does, the arguments you need to provide
And the default behavior of the macro so when someone calls it they don't need
To open the file to undertand it. 


Something to keep in mind is the tradeoff between DRY vs human readability. 
Be careful with how much you use them, and when you do so ADD DOCUMENTATION so 
people can understand what the code is doing without too much trouble. 
#}
