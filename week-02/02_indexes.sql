-- databáza: superstore

-- 4. úloha
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

SELECT * FROM orders WHERE customer_id = 'C001';

-- 5. úloha
CREATE INDEX idx_orders_order_date ON orders(order_date);

SELECT DATE_TRUNC('month', order_date) AS month, SUM(sales) FROM orders GROUP BY DATE_TRUNC('month', order_date) ORDER BY month ASC;

-- 6. úloha
CREATE INDEX idx_orders_region_category ON orders(customer_id, order_date);

SELECT customers.customer_name, customers.region, orders.order_id, orders.order_date, orders.sales, orders.profit FROM orders INNER JOIN customers ON customers.customer_id = orders.customer_id WHERE customers.region = 'West' AND orders.order_date >= '2024-01-01';

-- 7. úloha
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id = 'C001';
