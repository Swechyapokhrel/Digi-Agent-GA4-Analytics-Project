# Digi Agent GA4 Website Funnel Analytics Project

project-banner.png

## Project Overview

This project is a portfolio-ready **GA4 Website Funnel Analytics Project** created for **Digi Agent**, an IT company that provides digital services such as business websites, eCommerce stores, software systems, and digital solutions.

The goal of this project is to analyze how users discover the website, how they engage with landing pages, where the funnel loses potential leads, and which marketing channels contribute most effectively to business growth.

The project uses realistic synthetic datasets inspired by:

- Google Analytics 4 traffic acquisition data
- GA4 landing page performance data
- GA4 event and key event data
- Google Search Console SEO performance data
- CRM-style lead and customer data

This makes the project safe to publish publicly while still showing real-world marketing analytics thinking.

---

## Business Problem

Digi Agent receives website traffic from multiple digital channels, but traffic alone does not explain business performance.

The main business questions were:

1. Which channels bring the most engaged users?
2. Which landing pages generate the strongest lead conversion?
3. Where are users dropping off before becoming leads?
4. Which SEO queries have high potential but need optimization?
5. Which channels should receive more focus based on lead quality and revenue potential?

---

## Project Objectives

The objective of this project was to turn website and marketing data into clear business insights.

This project focuses on:

- Understanding website traffic performance
- Measuring engagement quality across channels
- Analyzing landing page funnel performance
- Connecting website activity with CRM leads
- Identifying SEO growth opportunities
- Recommending actions that can improve lead generation

---

## Tools Used

| Tool | Purpose |
|---|---|
| Excel | Data cleaning, dashboard creation, KPI analysis |
| SQL | Data modeling and analytical queries |
| GA4-style data | Website traffic and engagement analysis |
| Search Console-style data | SEO query and landing page analysis |
| CRM-style data | Lead, MQL, SQL, and customer tracking |
| GitHub | Project documentation and portfolio publishing |

---

## Repository Structure

```text
Digi-Agent-GA4-Analytics-Project/
│
├── raw data/
│   ├── raw ga4 traffic acquisition export.csv
│   ├── raw ga4 pages export.csv
│   ├── raw ga4 events export.csv
│   ├── raw gsc performance export.csv
│   └── raw crm leads export.csv
│
├── sql/
│   └── digi_agent_ga4_project_analysis.sql
│
├── assets/
│   └── readme/
│       ├── project-banner.png
│       ├── dashboard-overview.png
│       ├── funnel-analysis.png
│       ├── seo-opportunity.png
│       └── business-insights.png
│
├── Daily Performance.csv
├── landing page funnel.csv
├── seo query analysis.csv
├── Digi Agent GA4 Funnel Analytics.xlsx
└── README.md
```

---

## Dataset Description

The project includes five raw datasets and three cleaned analysis datasets.

### Raw Datasets

| Dataset | Description |
|---|---|
| GA4 Traffic Acquisition | Channel-level sessions, users, engagement, and conversions |
| GA4 Landing Pages | Landing page traffic, engagement, and key events |
| GA4 Events | Event-level user actions such as page views, scrolls, form starts, and form submissions |
| Search Console Export | Queries, clicks, impressions, CTR, and average position |
| CRM Leads Export | Leads, qualified leads, customers, and estimated revenue |

### Cleaned Analysis Datasets

| Dataset | Description |
|---|---|
| Daily Performance | Daily channel-level marketing and website performance |
| Landing Page Funnel | Landing page-level funnel performance |
| SEO Query Analysis | SEO query opportunity and optimization analysis |

---

## Key Metrics Analyzed

The analysis focused on the following KPIs:

| KPI | Why It Matters |
|---|---|
| Sessions | Measures website traffic volume |
| Users | Shows audience reach |
| Engaged Sessions | Measures quality visits |
| Engagement Rate | Helps evaluate content and traffic quality |
| Key Events | Tracks meaningful website actions |
| Website Key Event CVR | Measures website conversion efficiency |
| CRM Leads | Connects website activity to business outcomes |
| Lead Rate | Shows ability to convert visitors into leads |
| MQL Rate | Measures lead quality |
| SQL Rate | Measures sales-readiness |
| Customer Conversion Rate | Shows business impact |
| Estimated Revenue | Connects marketing performance to revenue |
| SEO CTR | Measures search result effectiveness |
| Average Position | Shows organic ranking strength |

---

## Dashboard Preview

![Dashboard Overview](assets/readme/dashboard-overview.png)

The Excel dashboard summarizes overall website performance, channel contribution, landing page results, SEO opportunities, and lead conversion performance.

It was designed to answer practical business questions, not just display numbers.

---

## Analysis Workflow

The project followed a structured analytics process:

### 1. Data Collection

Synthetic but realistic data was prepared to represent GA4, Search Console, and CRM exports.

### 2. Data Cleaning

The datasets were cleaned and standardized by:

- Formatting date fields
- Standardizing channel names
- Checking missing values
- Creating calculated metrics
- Preparing daily and landing page summaries

### 3. Data Modeling

The cleaned data connected marketing channels, landing pages, engagement metrics, SEO queries, and CRM outcomes.

### 4. KPI Analysis

Performance was analyzed across traffic, engagement, conversion, lead quality, and estimated revenue.

### 5. Business Insights

The final output focused on insights that a business owner or marketing manager could act on.

---

## Landing Page Funnel Analysis

![Landing Page Funnel Analysis](assets/readme/funnel-analysis.png)

The landing page analysis helped identify which pages attracted traffic and which pages actually converted users into leads.

This is important because high traffic does not always mean high business value.

The analysis compared:

- Sessions by landing page
- Engagement rate
- Key event conversion rate
- CRM lead volume
- Lead-to-customer conversion
- Estimated revenue contribution

---

## SEO Opportunity Analysis

![SEO Opportunity Analysis](assets/readme/seo-opportunity.png)

The SEO analysis identified search queries with strong growth potential.

Queries were evaluated based on:

- Impressions
- Clicks
- CTR
- Average search position
- Landing page relevance
- Conversion opportunity

This helped separate simple traffic keywords from keywords that could support real lead generation.

---

## Key Business Insights

![Business Insights](assets/readme/business-insights.png)

### 1. Organic Search showed strong engagement potential

Organic visitors showed meaningful engagement, making SEO an important long-term growth channel.

### 2. Paid Search performed better for high-intent traffic

Paid Search helped capture users who were closer to taking action, especially for service-related landing pages.

### 3. Some high-traffic pages had weak lead efficiency

The analysis showed that not every page with high sessions produced strong lead outcomes. These pages need better CTAs, clearer service messaging, and improved form placement.

### 4. SEO queries with high impressions but low CTR need optimization

Some queries had visibility but weak click performance. These are opportunities for better page titles, meta descriptions, and content alignment.

### 5. Connecting GA4 with CRM data gave better business understanding

GA4 metrics alone showed website activity, but CRM data helped reveal which channels and pages produced actual leads and customers.

---

## SQL Analysis Included

The SQL file includes analysis queries for:

- Channel performance
- Landing page conversion performance
- SEO opportunity analysis
- Monthly performance trends
- Lead quality by channel
- Revenue estimate by channel
- Website funnel performance
- High-traffic low-conversion pages
- Best-performing landing pages
- Channel-level business recommendations

Example SQL question answered:

```sql
-- Which channels generated the highest lead rate?
SELECT
    channel,
    SUM(sessions) AS total_sessions,
    SUM(crm_leads) AS total_leads,
    ROUND(SUM(crm_leads) * 1.0 / NULLIF(SUM(sessions), 0), 4) AS lead_rate
FROM clean_daily_performance
GROUP BY channel
ORDER BY lead_rate DESC;
```

---

## Excel Workbook Included

The Excel workbook includes:

- Raw data sheets
- Cleaned datasets
- KPI calculations
- Pivot-style summaries
- Dashboard visuals
- Business insight sections

The workbook was designed so the project can be reviewed by recruiters, hiring managers, or business stakeholders.

---

## Final Deliverables

| Deliverable | Description |
|---|---|
| Excel Workbook | Complete dashboard and analysis workbook |
| SQL File | Database schema and business analysis queries |
| Cleaned CSV Files | Processed datasets ready for analysis |
| Raw CSV Files | Original synthetic platform-style exports |
| Final Report | Business explanation, insights, and recommendations |
| README | Portfolio documentation for GitHub |

---

## Business Recommendations

Based on the analysis, Digi Agent should:

1. Improve CTAs on high-traffic but low-conversion pages.
2. Invest more effort into SEO pages with strong engagement signals.
3. Use Paid Search for high-intent service keywords.
4. Track CRM outcomes consistently with website source data.
5. Improve landing page copy for service pages with weak lead efficiency.
6. Build monthly performance reporting across GA4, Search Console, and CRM data.

---

## What This Project Demonstrates

This project demonstrates skills in:

- Marketing analytics
- Website funnel analysis
- GA4-style reporting
- SEO performance analysis
- CRM lead analysis
- Excel dashboarding
- SQL analysis
- Business problem-solving
- Data storytelling
- Portfolio documentation

---

## Why This Project Matters

Many marketing reports stop at traffic, clicks, or impressions.

This project goes further by connecting website behavior with lead generation and business outcomes.

It shows how marketing analytics can help a business understand:

- Where users come from
- What content they engage with
- Which pages convert
- Which SEO opportunities matter
- Which channels support revenue growth

