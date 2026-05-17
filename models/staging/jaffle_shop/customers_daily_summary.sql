select
    customer_id,
    order_date,
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'order_date']) }} as primary_key,
    count(*) as c
from {{ ref ('stg_jaffle_shop__orders') }}
group by 1, 2



-- So instead of grouping by both the customer Id and order date we can generate a surrogate key and group based
-- on that instead using the dbt utils package method generate_surrogate_key.

-- Make sure you run dbt deps first then you can use inside of your model