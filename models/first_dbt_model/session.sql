
{{
    config
    (
        materialized = 'table'
    )
}}

with session_src as
(
    SELECT
        SESSION_ID, 
        USER_ID, 
        BROWSER, 
        DEVICE_TYPE, 
        b.COUNTRY_NAME AS COUNTRY_NAME,
        b.Continent as continent,
        b.currency as currency,
        START_TIME, 
        END_TIME, 
        PAGES_VISITED,
        CURRENT_TIMESTAMP as INSERT_DTS
    FROM 
        {{ source('session_src', 'SESSION_SRC')}} as a 
    left join 
        {{ ref('country_code') }} b ON a.COUNTRY_CODE = b.COUNTRY_CODE
)

select * from session_src