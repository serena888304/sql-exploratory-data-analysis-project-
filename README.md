# sql-exploratory-data-analysis-project
An Exploratory Data Analysis (EDA) transforms raw retail data into actionable insights through customer segmentation, product performance tracking, and advanced SQL aggregations.

---

📊 **Exploratory Data Analysis (EDA) on Retail Data**
An Exploratory Data Analysis (EDA) project that transforms raw retail data into actionable insights through data profiling, magnitude analysis, and ranking.

---

🎯 **Project Objective**
The goal of this project is to perform a foundational data profiling and exploration exercise using MySQL. By following industry-standard analytical workflows, this project uncovers the underlying patterns, date ranges, and performance metrics within a retail database to establish a deep understanding of the dataset before building advanced reports.

---

🛠️ **Tools & Techniques Used**
SQL Dialect: MySQL

Techniques: Basic Aggregations (SUM, AVG, COUNT), GROUP BY logic, Sorting, and Date/Time Functions.

---

🗺️ **Analytical Methodology**
This project follows a structured, real-world data analysis roadmap to explore the dataset step-by-step:

Database Exploration: Inspecting tables, columns, and data types to understand the underlying schema and structure.

Dimension & Date Exploration: Identifying unique categorical values and analyzing the chronological timeframe of the sales data.

Measure Exploration: Calculating high-level metrics to gauge the size of the business (e.g., total customers, total orders, total products).

Magnitude Analysis: Combining dimensions and measures to understand distributions (e.g., finding the total sales generated per customer, or the number of orders per product).

Ranking Analysis: Identifying the top performers across the business to see what drives the most value (e.g., Top 10 Customers, Top 5 Products, Top Categories).

---
💡 Key Business Insights Discovered
Based on the Exploratory Data Analysis, here are the core findings about the business's performance, customer base, and product catalog:

High-Level Scale & Volume: The business operates at a significant scale, processing over 27,000 orders and selling exactly 60,423 items. This was achieved across a base of 18,484 unique customers, generating a total lifetime revenue of $29.3 Million.

The "Bike-Heavy" Revenue Engine:
While the company sells Accessories and Clothing, Bikes are the absolute core of the business. Bikes account for over 96% of total revenue ($28.3M out of $29.3M). Accessories and Clothing combine for barely $1M in revenue, indicating they act as supplementary add-ons rather than primary profit drivers.

Market Geography (The US Dominance):
The United States is by far the most valuable market, accounting for 40% of all customers (7,482) and driving the highest volume of sold items (20,481 items). Australia is the strong runner-up, bringing in nearly half the volume of the US, but still significantly outperforming the UK and European markets.

---

💻 **How to Use This Repository**
The scripts file contains all the SQL scripts categorized by the methodology steps above.

Ensure you have a MySQL environment set up with the retail database schema imported.

Run the queries sequentially to follow the data exploration journey.

---

**Acknowledgments:**
A huge thank you to Data with Baraa for the incredible tutorial series and for providing such high-quality, real-life materials to learn from. 
