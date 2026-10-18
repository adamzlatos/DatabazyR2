-- databáza: superstore

-- 1. úloha
WITH ranked_orders AS (SELECT customers.customer_name, orders.order_id, orders.order_date, ROW_NUMBER() OVER (PARTITION BY customers.customer_id ORDER BY orders.order_date DESC) AS rn FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id) SELECT customer_name, order_id, order_date FROM ranked_orders WHERE rn <= 2 ORDER BY customer_name, rn;

-- 2. úloha
WITH customer_profit AS (SELECT customers.region, customers.customer_name, SUM(orders.profit) AS total_profit FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.customer_id, customers.region, customers.customer_name) SELECT region, customer_name, total_profit, RANK() OVER (PARTITION BY region ORDER BY total_profit DESC) AS profit_rank, DENSE_RANK() OVER (PARTITION BY region ORDER BY total_profit DESC) AS profit_dense_rank FROM customer_profit ORDER BY region, profit_rank;

-- 3. úloha
WITH customer_sales AS (SELECT customers.customer_name, SUM(orders.sales) AS total_sales FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.customer_id, customers.customer_name) SELECT customer_name, total_sales, NTILE(4) OVER (ORDER BY total_sales DESC) AS quartile FROM customer_sales ORDER BY total_sales DESC;

-- 4. úloha
WITH monthly AS (SELECT DATE_TRUNC('month', order_date) AS month, SUM(sales) AS monthly_sales FROM orders GROUP BY DATE_TRUNC('month', order_date)) SELECT month, monthly_sales, LAG(monthly_sales, 1) OVER (ORDER BY month) AS prev_month_sales, LEAD(monthly_sales, 1) OVER (ORDER BY month) AS next_month_sales FROM monthly ORDER BY month ASC;

-- 5. úloha
WITH product_totals AS (SELECT p.category, p.product_name, SUM(o.sales) AS product_sales FROM orders o JOIN products p ON o.product_id = p.product_id GROUP BY p.category, p.product_name) SELECT category, product_name, product_sales, SUM(product_sales) OVER (PARTITION BY category) AS category_total, ROUND(product_sales * 100.0 / SUM(product_sales) OVER (PARTITION BY category), 2) AS pct_of_category FROM product_totals ORDER BY category, product_sales DESC;

-- 6. úloha
WITH customer_dates AS (SELECT c.customer_id, c.customer_name, MAX(o.order_date) OVER (PARTITION BY c.customer_id) AS last_order_date, MAX(o.order_date) OVER () AS latest_order_date FROM customers c JOIN orders o ON o.customer_id = c.customer_id) SELECT DISTINCT customer_id, customer_name, last_order_date FROM customer_dates WHERE last_order_date < latest_order_date - INTERVAL '90 days' ORDER BY last_order_date ASC;

-- 7. úloha
WITH monthly AS (SELECT DATE_TRUNC('month', order_date) AS month, SUM(sales) AS monthly_sales FROM orders GROUP BY DATE_TRUNC('month', order_date)), with_prev AS (SELECT month, monthly_sales, LAG(monthly_sales) OVER (ORDER BY month) AS prev_month_sales FROM monthly) SELECT month, monthly_sales, prev_month_sales, monthly_sales - prev_month_sales AS sales_change, ROUND((monthly_sales - prev_month_sales) / prev_month_sales * 100, 2) AS growth_percentage FROM with_prev ORDER BY month ASC;

-- 8. úloha
WITH first_purchase AS (SELECT customer_id, DATE_TRUNC('month', MIN(order_date)) AS first_month FROM orders GROUP BY customer_id) SELECT COUNT(*) AS returned_customers FROM first_purchase f WHERE f.first_month = '2024-06-01' AND EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = f.customer_id AND DATE_TRUNC('month', o.order_date) > f.first_month);
