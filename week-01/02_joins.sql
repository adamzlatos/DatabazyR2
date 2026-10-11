-- 1. úloha
SELECT * FROM orders;

-- 2. úloha
SELECT orders.order_id, customers.customer_name, orders.sales FROM orders INNER JOIN customers ON customers.customer_id = orders.customer_id WHERE sales > 500;

-- 3. úloha
SELECT orders.order_id, customers.customer_name, products.category, orders.sales FROM orders INNER JOIN customers ON customers.customer_id = orders.customer_id INNER JOIN products ON products.product_id = orders.product_id;

-- 6. úloha
SELECT customers.customer_name, orders.order_id, orders.sales FROM customers FULL OUTER JOIN orders ON orders.customer_id = customers.customer_id;
