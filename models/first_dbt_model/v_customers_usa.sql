{{
    config
    (
        materialized='view'
    )    
}}

SELECT * 
FROM {{ ref('customers') }}
WHERE country = 'USA'