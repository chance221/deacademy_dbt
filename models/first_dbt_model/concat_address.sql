{{
    config
    (
    materialized = 'table'
    )
}}

select {{ concat_macro('123 Street', 'Chicago') }} as address