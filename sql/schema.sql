-- ============================================
-- EXTENSIONS
-- ============================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- ============================================
-- ANALYTICS EVENTS (Partitioned)
-- ============================================

-- Using PARTITION BY RANGE for monthly partitioning
CREATE TABLE analytics_events (
    id              UUID         DEFAULT uuid_generate_v4(),
    user_id         VARCHAR(128) NOT NULL,
    event_type      VARCHAR(64)  NOT NULL,
    event_data      JSONB        DEFAULT '{}',
    locale          VARCHAR(5)   NOT NULL DEFAULT 'en',
    client_version  VARCHAR(16),
    platform        VARCHAR(10),
    session_id      VARCHAR(64),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

CREATE INDEX idx_analytics_user_id      ON analytics_events (user_id);
CREATE INDEX idx_analytics_event_type   ON analytics_events (event_type);
CREATE INDEX idx_analytics_created_at   ON analytics_events (created_at);
CREATE INDEX idx_analytics_locale       ON analytics_events (locale);
CREATE INDEX idx_analytics_composite    ON analytics_events (user_id, event_type, created_at);
CREATE INDEX idx_analytics_event_data   ON analytics_events USING GIN (event_data);

-- Partitioning by month for query performance
CREATE TABLE analytics_events_y2026m01 PARTITION OF analytics_events
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');
CREATE TABLE analytics_events_y2026m02 PARTITION OF analytics_events
    FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
CREATE TABLE analytics_events_y2026m03 PARTITION OF analytics_events
    FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');
-- (continue monthly partitions via cron job / Cloud Function)

-- ============================================
-- SUBSCRIPTION HISTORY
-- ============================================

CREATE TABLE subscription_history (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         VARCHAR(128) NOT NULL,
    plan            VARCHAR(20)  NOT NULL CHECK (plan IN ('free', 'pro', 'legend')),
    amount          DECIMAL(10,2) NOT NULL DEFAULT 0,
    currency        VARCHAR(3)   NOT NULL DEFAULT 'USD',
    payment_provider VARCHAR(20) CHECK (payment_provider IN ('stripe', 'apple', 'google')),
    store_txn_id    VARCHAR(255),
    started_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    ended_at        TIMESTAMPTZ,
    status          VARCHAR(20)  NOT NULL CHECK (status IN ('active', 'cancelled', 'expired', 'refunded', 'trial')),
    cancellation_reason TEXT,
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_sub_user_id    ON subscription_history (user_id);
CREATE INDEX idx_sub_status     ON subscription_history (status);
CREATE INDEX idx_sub_plan       ON subscription_history (plan);
CREATE INDEX idx_sub_started_at ON subscription_history (started_at);
CREATE INDEX idx_sub_composite  ON subscription_history (user_id, status, started_at);

-- ============================================
-- AI USAGE LOG
-- ============================================

CREATE TABLE ai_usage_log (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         VARCHAR(128) NOT NULL,
    model           VARCHAR(64)  NOT NULL,
    tokens_in       INTEGER      NOT NULL DEFAULT 0,
    tokens_out      INTEGER      NOT NULL DEFAULT 0,
    cost_usd        DECIMAL(10,6) NOT NULL DEFAULT 0,
    locale          VARCHAR(5)   NOT NULL DEFAULT 'en',
    endpoint        VARCHAR(128) NOT NULL,
    prompt_hash     VARCHAR(64),
    cache_hit       BOOLEAN      NOT NULL DEFAULT FALSE,
    latency_ms      INTEGER,
    status          VARCHAR(20)  NOT NULL DEFAULT 'success' CHECK (status IN ('success', 'error', 'timeout', 'filtered')),
    error_code      VARCHAR(64),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_ai_user_id     ON ai_usage_log (user_id);
CREATE INDEX idx_ai_model       ON ai_usage_log (model);
CREATE INDEX idx_ai_endpoint    ON ai_usage_log (endpoint);
CREATE INDEX idx_ai_created_at  ON ai_usage_log (created_at);
CREATE INDEX idx_ai_composite   ON ai_usage_log (user_id, model, created_at);
CREATE INDEX idx_ai_cost        ON ai_usage_log (cost_usd, created_at);

-- ============================================
-- NOTIFICATION LOG
-- ============================================

CREATE TABLE notification_log (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         VARCHAR(128) NOT NULL,
    type            VARCHAR(32)  NOT NULL,
    channel         VARCHAR(10)  NOT NULL CHECK (channel IN ('fcm', 'apns', 'sms', 'email')),
    status          VARCHAR(20)  NOT NULL CHECK (status IN ('sent', 'delivered', 'failed', 'bounced', 'opened')),
    locale          VARCHAR(5)   NOT NULL DEFAULT 'en',
    title           VARCHAR(255),
    error_message   TEXT,
    fcm_message_id  VARCHAR(255),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_notif_user_id    ON notification_log (user_id);
CREATE INDEX idx_notif_type       ON notification_log (type);
CREATE INDEX idx_notif_status     ON notification_log (status);
CREATE INDEX idx_notif_channel    ON notification_log (channel);
CREATE INDEX idx_notif_created_at ON notification_log (created_at);
CREATE INDEX idx_notif_composite  ON notification_log (user_id, type, created_at);

-- ============================================
-- AGGREGATION VIEWS
-- ============================================

CREATE MATERIALIZED VIEW mv_daily_ai_cost AS
SELECT
    DATE(created_at) AS day,
    model,
    locale,
    COUNT(*)           AS request_count,
    SUM(tokens_in)     AS total_tokens_in,
    SUM(tokens_out)    AS total_tokens_out,
    SUM(cost_usd)      AS total_cost,
    AVG(latency_ms)    AS avg_latency_ms,
    SUM(CASE WHEN cache_hit THEN 1 ELSE 0 END) AS cache_hits
FROM ai_usage_log
GROUP BY DATE(created_at), model, locale;

CREATE MATERIALIZED VIEW mv_monthly_revenue AS
SELECT
    DATE_TRUNC('month', started_at) AS month,
    plan,
    currency,
    COUNT(*)          AS subscriptions,
    SUM(amount)       AS total_revenue
FROM subscription_history
WHERE status IN ('active', 'cancelled')
GROUP BY DATE_TRUNC('month', started_at), plan, currency;

-- Refresh schedule: daily via Cloud Scheduler -> Cloud Function
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_daily_ai_cost;
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_monthly_revenue;
