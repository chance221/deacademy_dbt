
with payments as 
(
    select *
    from {{ ref('stg_stripe__payments')}}
    where status = 'success'
),

-- This is going to be refactored to hold a list of pyament types
-- we can also create ascript that calculates each payment then loop through the list to get the correct amount for each payment type. 
pivoted_original as (
    select 
        order_id
        , sum(case when payment_method = 'bank_transfer' then amount else 0 end) as bank_transferer_amount
        , sum(case when payment_method = 'credit_card' then amount else 0 end) as credit_card_amount
        , sum(case when payment_method = 'gift_card' then amount else 0 end) as gift_card_amount
        , sum(case when payment_method = 'cupon' then amount else 0 end) as cupon_amount
    from payments
    group by 1
    order by order_id
),

pivoted_jinja as (
    select 
        order_id,

        {%- set payment_methods = ['bank_transfer', 'credit_card', 'gift_card', 'cupon'] -%}

        {% for payment_method in payment_methods %}        
        
            sum(
                case 
                    when payment_method = '{{ payment_method }}' then amount else 0 
                end
            ) as {{ payment_method}}_amount

            {%- if not loop.last -%}
                ,
            {%- endif -%}

        {% endfor %}
        
    from payments
    group by 1
    order by order_id
)



select *
from pivoted_jinja

{#
**********
-- TO protect this list we can add a test to see if any additional values were added. We can fail the job if so and re-run after all unique values are needed. 
-- This has a lower cost than querying for the unque list before every job to create the list dynamically, which is possible looking  at the docs below 
-- also you can store this as a variable in a .yml file and reference in multiple models this way along with assuring the values are not stale

-- We can create a for loop then create the case statement to run for each payment method, 
-- but we need to keep in mind the comma at the end of the for statement 
-- also notice the "-" in the jinja blocks. This tells jinja not to add a line to the compiled code so its still readabale 
**********

**********
This is the main manual for standard loops, if-statements, variables, and whitespace control.
Official Jinja Template Designer Documentation - https://jinja.palletsprojects.com/en/stable/templates/
**********


**********
Official Jinja Built-in Filters: The direct reference page for using filters like | unique and
https://stackoverflow.com/questions/2061439/string-concatenation-in-jinja
**********


**********
https://docs.getdbt.com/guides/using-jinja
dbt Guide: Using Jinja to Pivot Columns: This is a step-by-step tutorial written by dbt 
that details the exact use case querying a list of payment methods and looping over them to sum columns.
**********


**********
https://docs.getdbt.com/reference/dbt-jinja-functions/run_query
dbt Reference: About the run_query Macro: The technical manual for run_query, 
explaining how it interacts with the database adapter and executes during compile time.
**********


**********
https://docs.getdbt.com/reference/dbt-jinja-functions-context-variables
dbt Reference: Jinja Functions & Context Variables: 
The comprehensive list of custom functions dbt injects into Jinja, 
including features like formatting, flags, and execute checks
**********


#}

