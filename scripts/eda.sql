/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To understand the underlying structure of the database.
    - To identify available tables and inspect column details for specific tables.

SQL Functions Used:
    - INFORMATION_SCHEMA.TABLES, INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/
SELECT * FROM INFORMATION_SCHEMA.TABLES;

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

/*
===============================================================================
Dimension Exploration
===============================================================================
Purpose:
    - To identify unique categorical values within the dataset.
    - To understand the geographical spread and the major product categorizations.

SQL Functions Used:
    - DISTINCT, ORDER BY
===============================================================================
*/
-- Explore All Countries our customer come from
SELECT DISTINCT 
	country
FROM DataWarehouseAnalytics.dim_customers;

-- Explore All Categories "The major Divisions"
SELECT DISTINCT
	category,
    subcategory,
    product_name
FROM DataWarehouseAnalytics.dim_products
ORDER BY category;

/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical sales data and customer age demographics.

SQL Functions Used:
    - MIN(), MAX(), TIMESTAMPDIFF(), CURRENT_TIMESTAMP
===============================================================================
*/
-- Find the date of the first and last order, how many years of sales are available
SELECT
	MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    TIMESTAMPDIFF(year, MIN(order_date), MAX(order_date)) As order_range_years,  -- Tell the stamp difference in years. only gives a "point" for a year or a month once it is 100% finished.
    TIMESTAMPDIFF(month, MIN(order_date), MAX(order_date)) As order_range_months  -- Tell the stamp difference in months
FROM DataWarehouseAnalytics.fact_sales;

/*
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_date = '' THEN 1 ELSE 0 END) AS empty_strings,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS real_nulls
FROM DataWarehouseAnalytics.fact_sales;
*/

-- Find the youngest and the oldest customer
SELECT
	MIN(birthdate) AS oldest_birthdate,
    TIMESTAMPDIFF(year, MIN(birthdate), CURRENT_TIMESTAMP) AS olderest_age,
    MAX(birthdate) AS youngest_birthdate,
    TIMESTAMPDIFF(year, MAX(birthdate), CURRENT_TIMESTAMP) AS youngest_age
FROM DataWarehouseAnalytics.dim_customers;

/*
===============================================================================
Measures Exploration
===============================================================================
Purpose:
    - To calculate high-level aggregated metrics to gauge the overall scale of the business.
    - To combine multiple single-value KPIs into a single, consolidated summary report.

SQL Functions Used:
    - SUM(), AVG(), COUNT(), COUNT(DISTINCT), UNION ALL
===============================================================================
*/
-- Find the Total Sales
SELECT
	SUM(sales_amount) AS total_sales
FROM DataWarehouseAnalytics.fact_sales;

-- Find how many items are sold
SELECT
	SUM(quantity) AS total_quantity
FROM DataWarehouseAnalytics.fact_sales;

-- Find the average selling price
SELECT
	AVG(price) AS avg_price
FROM DataWarehouseAnalytics.fact_sales;

-- Find the total number of orders
/*
SELECT
	COUNT(order_number) AS total_order
FROM DataWarehouseAnalytics.fact_sales;
*/

SELECT 
	COUNT(DISTINCT order_number) AS total_order
FROM DataWarehouseAnalytics.fact_sales;

-- Find the total number of products
SELECT
	COUNT(DISTINCT product_id) AS total_products
FROM DataWarehouseAnalytics.dim_products;

-- Find the total number of customers
SELECT 
	COUNT(customer_id) AS total_customers
FROM DataWarehouseAnalytics.dim_customers;

-- Find the total number of customers that has placed an order
SELECT 
	COUNT(distinct customer_key) AS total_customers
FROM DataWarehouseAnalytics.fact_sales;

-- Generate a Report that shows all key metric of the business
SELECT
	'Total Sales' AS measure_name,
	SUM(sales_amount) AS measure_value
FROM DataWarehouseAnalytics.fact_sales

UNION ALL

SELECT
	'Total Quantity' AS measure_name,
	SUM(quantity) AS measure_value
FROM DataWarehouseAnalytics.fact_sales

UNION ALL

SELECT
	'Average Price' AS measure_name,
	AVG(price) AS measure_value
FROM DataWarehouseAnalytics.fact_sales

UNION ALL

SELECT
	'Total Order' AS measure_name,
	COUNT(DISTINCT order_number) AS measure_value
FROM DataWarehouseAnalytics.fact_sales

UNION ALL

SELECT
	'Total Products' AS measure_name,
	COUNT(DISTINCT product_id) AS measure_value
FROM DataWarehouseAnalytics.dim_products

UNION ALL

SELECT
	'Total Customers' AS measure_name,
	COUNT(distinct customer_key) AS measure_value
FROM DataWarehouseAnalytics.fact_sales;

/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To analyze the distribution of quantitative measures across different categorical dimensions.
    - To identify high-level trends such as sales volume by country or revenue by category.

SQL Functions Used:
    - GROUP BY, ORDER BY, LEFT JOIN, SUM(), AVG(), COUNT()
===============================================================================
*/
-- Find total customer by countries
SELECT
	country,
	COUNT(customer_key) AS total_customer
FROM DataWarehouseAnalytics.dim_customers
GROUP BY country
ORDER BY total_customer DESC;

-- Find total customer by gender
SELECT
	gender,
	COUNT(customer_id) AS total_customer
FROM DataWarehouseAnalytics.dim_customers
GROUP BY gender
ORDER BY total_customer DESC;

-- Find total products by category
SELECT
	category,
    COUNT(product_key) AS total_product
FROM DataWarehouseAnalytics.dim_products
GROUP BY category
ORDER BY total_product DESC;

-- What is the average costs in each category?
SELECT
	category,
    AVG(cost) AS avg_costs
FROM DataWarehouseAnalytics.dim_products
GROUP BY category
ORDER BY avg_costs DESC;

-- What is the total revenue generated for each category?
SELECT
	p.category,
	SUM(f.sales_amount) AS total_revenue
FROM DataWarehouseAnalytics.fact_sales f
LEFT JOIN dim_products p ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Find total revenue is generated by each customers
SELECT
	c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) As total_revenue
FROM DataWarehouseAnalytics.fact_sales f
LEFT JOIN dim_customers c ON f.customer_key = c.customer_key
GROUP BY 
	c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;


-- What is the distribution of sold items across countries?
SELECT
	c.country,
    SUM(f.quantity) AS total_sold_items
FROM DataWarehouseAnalytics.fact_sales f
LEFT JOIN dim_customers c ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC;

/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To identify the top and bottom performers within the business (e.g., best-selling products, most valuable customers).
    - To provide insights for targeted marketing and inventory decisions.

SQL Functions Used:
    - LIMIT, ROW_NUMBER() OVER(), ORDER BY DESC/ASC
===============================================================================
*/
-- Which 5 products generate the highest revenue?
SELECT
	p.product_name,
    SUM(f.sales_amount) as total_revenue
FROM DataWarehouseAnalytics.fact_sales f
LEFT JOIN dim_products p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Which 5 products generate the highest revenue? (window function)
SELECT * 
FROM(
	SELECT
		p.product_name,
		SUM(f.sales_amount) as total_revenue,
		ROW_NUMBER()OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
	FROM DataWarehouseAnalytics.fact_sales f
	LEFT JOIN dim_products p ON f.product_key = p.product_key
	GROUP BY p.product_name
	ORDER BY total_revenue DESC)t
WHERE rank_products <=5;

-- What are the 5 worst-performaning products in terms of sales?
SELECT
	p.product_name,
    SUM(f.sales_amount) as total_revenue
FROM DataWarehouseAnalytics.fact_sales f
LEFT JOIN dim_products p ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue
LIMIT 5;

-- Find the top 10 customers who have generated the highest revenue
SELECT
	c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) As total_revenue
FROM DataWarehouseAnalytics.fact_sales f
LEFT JOIN dim_customers c ON f.customer_key = c.customer_key
GROUP BY 
	c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Find the 3 customers with fewest orders placed
SELECT
	c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(distinct order_number) As total_orders
FROM DataWarehouseAnalytics.fact_sales f
LEFT JOIN dim_customers c ON f.customer_key = c.customer_key
GROUP BY 
	c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders ASC, c.customer_key ASC
LIMIT 3;

SELECT * FROM dim_customers;




