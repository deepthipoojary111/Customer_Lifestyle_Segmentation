# Customer Lifecycle Segmentation SQL Project

## Project Overview
This project focuses on analyzing customer purchasing behavior and segmenting customers into different lifecycle stages using SQL. The dataset contains customer demographics, transaction history, and lifecycle KPIs.

## Dataset Information

### Sheets Used

| Sheet Name | Description |
|------------|-------------|
| Customers | 500 customers with demographics such as age, gender, and city |
| Orders | Transaction data from 2023-01-01 to 2025-04-22 |
| Lifecycle_Summary | Customer KPIs with lifecycle stage labels |

---

## Lifecycle Stage Rules

| Stage | Rule |
|------|------|
| New | days_since_purchase ≤ 30 AND total_orders ≤ 2 |
| Active | days_since_purchase ≤ 90 AND total_orders < 5 |
| Loyal | days_since_purchase ≤ 90 AND total_orders ≥ 5 |
| At-Risk | days_since_purchase between 91 and 180 |
| Churned | days_since_purchase > 180 |

---

## Orders Table Columns

| Column Name | Description |
|------------|-------------|
| order_id | Unique order identifier |
| customer_id | Foreign key to Customers |
| order_date | Transaction date |
| product_category | Purchased product category |
| quantity | Units purchased |
| unit_price | Price per unit |
| total_amount | quantity × unit_price |
| discount_pct | Discount percentage applied |
| net_amount | Revenue after discount |
| order_status | Completed / Cancelled / Returned |
| channel | Online / Mobile App / In-Store |

---

## SQL Concepts Used
- SELECT Statements
- WHERE Clause
- GROUP BY
- ORDER BY
- Aggregate Functions
- JOINS
- Subqueries
- CASE Statements
- Views
- Foreign Keys

---

## Insights Generated
- Identified loyal and churned customers
- Analyzed customer purchasing trends
- Evaluated sales by product category
- Compared revenue across sales channels
- Generated lifecycle-based customer segmentation

---

## Tools Used
- MySQL
- SQL
- GitHub
