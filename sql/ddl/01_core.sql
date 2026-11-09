CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS mart;

CREATE TABLE IF NOT EXISTS core.prices_clean (
    price_id             bigint PRIMARY KEY,
    created_at           timestamp(0),
    organization_id      integer,
    subscriber_id        integer,
    loading_date         date NOT NULL,
    loading_city_gcid    integer NOT NULL,
    unloading_city_gcid  integer NOT NULL,
    distance             double precision NOT NULL,
    total_weight         double precision NOT NULL,
    total_volume         double precision NOT NULL,
    body_type            integer,
    body_group           varchar(32) NOT NULL,  
    weight_category      varchar(4) NOT NULL,
    volume_category      varchar(4) NOT NULL,
    price                double precision NOT NULL, 
    currency_code        varchar(3) NOT NULL,
    price_rub            double precision NOT NULL, 
    exchange_rate        double precision,          
    rate_date            date,                      
    price_type           smallint NOT NULL,
    is_fact              boolean NOT NULL,
    complex              boolean NOT NULL,
    outlier_mark         boolean NOT NULL,
    price_date_month     date NOT NULL,              
    loaded_at            timestamp NOT NULL DEFAULT now(),
    run_id               uuid NOT NULL               
);
CREATE INDEX IF NOT EXISTS idx_prices_clean_month
    ON core.prices_clean (price_date_month);
CREATE INDEX IF NOT EXISTS idx_prices_clean_route
    ON core.prices_clean (loading_city_gcid, unloading_city_gcid, price_date_month);

CREATE TABLE IF NOT EXISTS core.dq_quarantine_prices (
    price_id             bigint,
    reason_code          varchar(32) NOT NULL,  
    details              jsonb,
    quarantined_at       timestamp NOT NULL DEFAULT now(),
    run_id               uuid NOT NULL,
    PRIMARY KEY (price_id, reason_code, run_id)
);

CREATE TABLE IF NOT EXISTS core.etl_runs (
    run_id         uuid PRIMARY KEY,
    start_date     date NOT NULL,
    end_date       date NOT NULL,
    started_at     timestamp NOT NULL DEFAULT now(),
    finished_at    timestamp,
    rows_read      bigint,
    rows_loaded    bigint,
    rows_quarantined bigint,
    status         varchar(16) NOT NULL DEFAULT 'running'
);