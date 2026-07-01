

CREATE TABLE ga4_traffic_acquisition (
    report_date DATE,
    session_source_medium VARCHAR(100),
    default_channel_group VARCHAR(50),
    campaign_name VARCHAR(120),
    sessions INT,
    total_users INT,
    new_users INT,
    engaged_sessions INT,
    average_engagement_time_seconds INT,
    event_count INT,
    key_events INT,
    cost_usd DECIMAL(12,2)
);

DROP TABLE IF EXISTS ga4_landing_pages;
CREATE TABLE ga4_landing_pages (
    report_date DATE,
    landing_page VARCHAR(255),
    page_title VARCHAR(255),
    views INT,
    users INT,
    entrances INT,
    engaged_sessions INT,
    average_engagement_time_seconds INT,
    form_submit_events INT,
    phone_click_events INT,
    whatsapp_click_events INT
);

DROP TABLE IF EXISTS ga4_events;
CREATE TABLE ga4_events (
    report_date DATE,
    event_name VARCHAR(100),
    page_path VARCHAR(255),
    event_count INT,
    users INT
);

DROP TABLE IF EXISTS gsc_performance;
CREATE TABLE gsc_performance (
    report_date DATE,
    query_text VARCHAR(255),
    page VARCHAR(255),
    country VARCHAR(80),
    device VARCHAR(50),
    clicks INT,
    impressions INT,
    ctr DECIMAL(8,4),
    average_position DECIMAL(8,2)
);

DROP TABLE IF EXISTS crm_leads;
CREATE TABLE crm_leads (
    lead_id VARCHAR(20) PRIMARY KEY,
    lead_created_date DATE,
    source_medium VARCHAR(100),
    default_channel_group VARCHAR(50),
    campaign_name VARCHAR(120),
    landing_page VARCHAR(255),
    service_interest VARCHAR(120),
    lead_status VARCHAR(50),
    is_mql VARCHAR(5),
    is_sql VARCHAR(5),
    became_customer VARCHAR(5),
    estimated_deal_value_usd DECIMAL(12,2),
    city VARCHAR(80),
    customer_type VARCHAR(120)
);

-- Example MySQL import commands.
-- Update file paths before running on your computer/server.
-- LOAD DATA LOCAL INFILE '/path/raw_ga4_traffic_acquisition_export.csv'
-- INTO TABLE ga4_traffic_acquisition
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;
--
-- Repeat for each CSV file.

-- ==========================================================
-- ANALYSIS QUERIES
-- ==========================================================

-- 1. Channel performance: sessions, engagement, leads, customers, CPA, and ROAS.
SELECT
    t.default_channel_group,
    SUM(t.sessions) AS sessions,
    SUM(t.total_users) AS users,
    ROUND(SUM(t.engaged_sessions) / NULLIF(SUM(t.sessions), 0), 4) AS engagement_rate,
    SUM(t.key_events) AS key_events,
    ROUND(SUM(t.key_events) / NULLIF(SUM(t.sessions), 0), 4) AS website_key_event_cvr,
    COUNT(l.lead_id) AS crm_leads,
    SUM(CASE WHEN l.is_mql = 'Yes' THEN 1 ELSE 0 END) AS mqls,
    SUM(CASE WHEN l.is_sql = 'Yes' THEN 1 ELSE 0 END) AS sqls,
    SUM(CASE WHEN l.became_customer = 'Yes' THEN 1 ELSE 0 END) AS customers,
    ROUND(SUM(l.estimated_deal_value_usd), 2) AS estimated_revenue,
    ROUND(SUM(t.cost_usd), 2) AS cost_usd,
    ROUND(SUM(t.cost_usd) / NULLIF(COUNT(l.lead_id), 0), 2) AS cost_per_lead,
    ROUND(SUM(l.estimated_deal_value_usd) / NULLIF(SUM(t.cost_usd), 0), 2) AS roas
FROM ga4_traffic_acquisition t
LEFT JOIN crm_leads l
    ON t.report_date = l.lead_created_date
    AND t.default_channel_group = l.default_channel_group
GROUP BY t.default_channel_group
ORDER BY crm_leads DESC;

-- 2. Landing page funnel: entrances to CRM lead rate.
SELECT
    p.landing_page,
    p.page_title,
    SUM(p.views) AS views,
    SUM(p.entrances) AS entrances,
    SUM(p.form_submit_events + p.phone_click_events + p.whatsapp_click_events) AS cta_events,
    COUNT(l.lead_id) AS crm_leads,
    ROUND(COUNT(l.lead_id) / NULLIF(SUM(p.entrances), 0), 4) AS landing_lead_rate,
    SUM(CASE WHEN l.became_customer = 'Yes' THEN 1 ELSE 0 END) AS customers,
    ROUND(SUM(l.estimated_deal_value_usd), 2) AS estimated_revenue
FROM ga4_landing_pages p
LEFT JOIN crm_leads l
    ON p.report_date = l.lead_created_date
    AND p.landing_page = l.landing_page
GROUP BY p.landing_page, p.page_title
ORDER BY crm_leads DESC;

-- 3. SEO opportunities: high impressions with weaker average position.
SELECT
    query_text,
    page,
    SUM(clicks) AS clicks,
    SUM(impressions) AS impressions,
    ROUND(SUM(clicks) / NULLIF(SUM(impressions), 0), 4) AS ctr,
    ROUND(SUM(average_position * impressions) / NULLIF(SUM(impressions), 0), 2) AS weighted_avg_position
FROM gsc_performance
GROUP BY query_text, page
HAVING impressions > 10000
ORDER BY weighted_avg_position DESC, impressions DESC;

-- 4. Monthly trend by channel.
SELECT
    DATE_FORMAT(report_date, '%Y-%m') AS month,
    default_channel_group,
    SUM(sessions) AS sessions,
    SUM(key_events) AS key_events,
    ROUND(SUM(key_events) / NULLIF(SUM(sessions), 0), 4) AS key_event_cvr,
    ROUND(SUM(cost_usd), 2) AS cost_usd
FROM ga4_traffic_acquisition
GROUP BY DATE_FORMAT(report_date, '%Y-%m'), default_channel_group
ORDER BY month, default_channel_group;

-- 5. Service interest performance from CRM.
SELECT
    service_interest,
    COUNT(*) AS leads,
    SUM(CASE WHEN is_mql = 'Yes' THEN 1 ELSE 0 END) AS mqls,
    SUM(CASE WHEN is_sql = 'Yes' THEN 1 ELSE 0 END) AS sqls,
    SUM(CASE WHEN became_customer = 'Yes' THEN 1 ELSE 0 END) AS customers,
    ROUND(SUM(estimated_deal_value_usd), 2) AS estimated_revenue
FROM crm_leads
GROUP BY service_interest
ORDER BY estimated_revenue DESC, leads DESC;
