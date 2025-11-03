# Root Cause Analysis (RCA) Using SQL: Investigating Sales Spike in May 2025

## Problem Statement
In May 2025, sales data showed a sudden spike. The business team suspected that product pricing changes and new product launches may have influenced this surge.  
This project demonstrates how a data analyst can use SQL-based Root Cause Analysis (RCA) to uncover the true drivers behind sales anomalies using realistic, structured, and referentially integrated data models.

---

## Objective
The goal of this simulation project is to perform hands-on Root Cause Analysis using SQL Server by:
- Designing a normalized schema with referential integrity (Dimension and Fact tables).
- Generating synthetic but realistic product, price, and sales data across 2025.
- Detecting sales anomalies (spikes) and identifying causal factors (price drops, new product launches).
- Showcasing analytical storytelling through data-driven insights using SQL.

---

## STAR Format Overview

### Situation
A retail business observed an unusual sales spike in May 2025. They wanted to understand if it was caused by internal business decisions (like pricing changes or product introductions) or external factors.

### Task
Build a mini data warehouse schema and use SQL Root Cause Analysis to pinpoint what led to the spike.  
The analysis had to be replicable, auditable, and based on real-world data modeling practices (dimensional model with fact and dimension tables).

### Action
1. **Schema Design**
   - Created schema `rca` with the following tables:
     - `rca.dim_product`: Product master data.
     - `rca.dim_date`: Calendar dimension (Jan–Dec 2025).
     - `rca.dim_product_price`: Monthly price history of all products.
     - `rca.fact_sales`: Transactional sales fact table capturing quantity and unit price.

2. **Data Simulation**
   - Added 3 base products (Jan–Apr) and 2 new products (May onward).
   - Simulated monthly price changes and sales transactions (10–15 per month).
   - Designed realistic May 2025 scenario: price drops and new product launches leading to a sales spike.

3. **Root Cause Analysis Queries**
   - Compared month-over-month sales volume and revenue growth.
   - Correlated price changes with sales spike percentage.
   - Identified products contributing most to the spike.
   - Measured price elasticity using SQL aggregations.

4. **Insights Delivered Using SQL**
   - Used CTEs (Common Table Expressions), window functions, and joins to trace causality.
   - Built trend views for easy visualization in BI tools like Power BI or Tableau.

### Result
The SQL analysis revealed that:
- Average product prices dropped by 15–20% in May 2025.
- Two new products contributed 40% of total May revenue.
- The sales spike was primarily driven by price reductions and new product launches, not seasonality.

This finding allowed the business to strategically plan future promotions and adjust inventory management based on data-driven insights.

---

## SQL Schema Overview

```sql
Schema: rca

Tables:
1. dim_date(date_key, full_date, month_name, year)
2. dim_product(product_id, product_name, category)
3. dim_product_price(product_id, price_month, price)
4. fact_sales(sale_id, sale_date, product_id, quantity, unit_price, total_amount)
