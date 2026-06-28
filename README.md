# sql-exploratory-data-analysis-project
A foundational MySQL exploratory data analysis project that profiles a retail dataset and summarizes key business dimensions, including customers, products, orders, revenue, date ranges, and regional performance.

This project represents the first stage of a two-part SQL portfolio project. The objective is to understand the dataset structure, business scale, product mix, customer distribution, and high-level performance patterns before moving into advanced SQL analytics and reporting-layer development.

---

📊 **Exploratory Data Analysis (EDA) on Retail Data**

An Exploratory Data Analysis (EDA) project that transforms raw retail data into actionable insights through data profiling, magnitude analysis, and ranking.

---

🎯 **Project Background**

This project uses a simulated retail dataset representing a global bicycle and cycling gear business.

The company processes a large volume of historical sales transactions across multiple customers, products, and regions. This project performs foundational data exploration to understand the structure, scale, and key business patterns within the dataset before deeper analytical modeling and reporting-layer development.

The analysis focuses on the following foundational areas:

- **Database Structure:** Understanding the tables, columns, relationships, and available fields in the retail database.
- **Business Scale:** Measuring total revenue, total orders, total items sold, total customers, and total products.
- **Product Overview:** Identifying major product categories and top-selling products based on revenue and volume.
- **Customer Overview:** Exploring customer counts, customer distribution, and top customers by revenue.
- **Regional Overview:** Comparing customer base size, sales volume, and item sales across major geographic markets.

---

🛠️ **Data Structure**

The database consists of three relational tables structured in a Star Schema. The core sales fact table captures over **60,400 item-level transaction records** (spanning 27,000+ distinct orders), supported by comprehensive customer and product dimension tables.

<img width="671" height="321" alt="ERD" src="https://github.com/user-attachments/assets/8312d358-630b-47a1-ba30-645d99ede03f" />

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
**💡 Key Business Insights Discovered**

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
