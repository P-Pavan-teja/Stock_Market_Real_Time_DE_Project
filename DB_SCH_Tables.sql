CREATE OR REPLACE DATABASE STOCKS_MDS;
CREATE OR REPLACE SCHEMA STOCKS_MDS.COMMON;

CREATE OR REPLACE TABLE STOCKS_MDS.COMMON.bronze_stock_quotes_raw(
V VARIANT
);

SELECT * FROM STOCKS_MDS.COMMON.bronze_stock_quotes_raw;

SELECT 
    v:c::float AS current_price,
    v:d::float AS change_amount,
    v:dp::float AS change_percent,
    v:h::float AS day_high,
    v:l::float AS day_low,
    v:o::float AS day_open,
    v:pc::float AS prev_close,
    v:t::timestamp AS market_timestamp,
    v:symbol::string AS symbol,
    v:time::timestamp AS fetched_at
FROM STOCKS_MDS.COMMON.BRONZE_STOCK_QUOTES_RAW;
SELECT 
    v:c::float AS current_price,
    v:d::float AS change_amount,
    v:dp::float AS change_percent,
    v:h::float AS day_high,
    v:l::float AS day_low,
    v:o::float AS day_open,
    v:pc::float AS prev_close,
    v:t::timestamp AS market_timestamp,
    v:symbol::string AS symbol,
    v:time::timestamp AS fetched_at
FROM {{ source('raw', 'bronze_stock_quotes_raw') }};

SELECT
    symbol,
    current_price,
    ROUND(day_high, 2) AS day_high,
    ROUND(day_low, 2) AS day_low,
    ROUND(day_open, 2) AS day_open,
    ROUND(prev_close, 2) AS prev_close,
    change_amount,
    ROUND(change_percent, 4) AS change_percent,
    market_timestamp,
    fetched_at
FROM {{ ref('bronze_stg_stock_quotes') }}
WHERE current_price IS NOT NULL ;

