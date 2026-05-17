
select
  ID as customer_id,
  first_name,
  last_name,
  _etl_loaded_at
from {{ source('jaffle_shop', 'CUSTOMERS') }}