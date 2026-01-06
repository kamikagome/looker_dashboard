# 📊 Superstore Data Analysis Project

![Looker Status](https://img.shields.io/badge/Looker-Data%20Modeling-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)
![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)

## 📖 Project Overview
This repository contains the **LookML** data model and dashboard configurations for analyzing the global **Superstore** dataset. The project provides actionable insights into sales performance, customer behavior, and product profitability across various regions and categories.

**Key Features:**
* **Dynamic Analysis:** Switch seamlessly between "Profit" and "Sales" views using parameterized fields.
* **Geospatial Intelligence:** Interactive maps visualizing performance by state and region.
* **Granular Drill-downs:** Deep dives into individual order details, return rates, and customer segments.
* **KPI Tracking:** Real-time tracking of Total Sales, Profit Margins, and Return Ratios.

---

## 🏗️ Data Architecture

The project is built on a PostgreSQL data warehouse using a Star Schema approach.


    ## 📈 Dashboard Highlights

### 1. Executive KPI Dashboard
A high-level view for stakeholders to monitor business health.
* **Top-line Metrics:** Total Sales, Total Profit, Order Count.
* **Trend Analysis:** Month-over-month growth charts.
* **Manager Performance:** Sales breakdown by Regional Manager.

### 2. Regional Performance
* **Heatmaps:** Visualizing profit ratios by State.
* **Category Analysis:** Identifying high-performing product sub-categories.

---

## 🛠️ Technical Implementation

### LookML Structure
* **`views/`**: Contains the logic for `orders`, `people`, and `returns` tables.
    * *Best Practice:* All fields are standardized to lowercase.
    * *Parameters:* "Profit or Sales" toggle enabled via Liquid templating.
* **`explorers/`**: Defines the join logic (`one_to_many` for returns, `many_to_one` for managers).
* **`models/`**: Configures the database connection and includes relevant explores.

### Key Code Snippet: Dynamic Measure
This Liquid parameter allows users to dynamically swap measures on charts.

```lookml
measure: dynamic_profit_or_sales {
  type: number
  sql: SUM(CASE
          WHEN {% condition profit_or_sales %} 'Profit' {% endcondition %} THEN ${profit}
          ELSE ${sales}
        END) ;;
}
