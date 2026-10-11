-- databáza: superstore

-- 1. úloha
CREATE VIEW high_value_customers AS SELECT customers.customer_id, customers.customer_name, SUM(orders.sales) AS total_sales FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.customer_id, customers.customer_name HAVING SUM(orders.sales) > 2000;

SELECT * FROM high_value_customers;

-- 2. úloha
CREATE VIEW regional_monthly_sales AS SELECT customers.region, DATE_TRUNC('month', orders.order_date) AS month, SUM(orders.sales) AS monthly_sales FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.region, DATE_TRUNC('month', orders.order_date);

SELECT * FROM regional_monthly_sales WHERE region = 'West' ORDER BY month;

-- 3. úloha
CREATE VIEW analyst_orders AS SELECT order_id, customer_id, product_id, sales, quantity, discount FROM orders;

SELECT * FROM analyst_orders;
