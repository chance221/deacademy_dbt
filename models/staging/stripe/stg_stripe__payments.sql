
select
    
  id as payment_id,
  orderid as order_id,
  paymentmethod as payment_method,
  {{ cents_to_dollars("amount") }} as amount,
  _batched_at as created_at,
  status
  

from {{ source('stripe', 'payment') }}

