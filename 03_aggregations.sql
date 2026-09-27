-- 4. úloha
SELECT customers.region, SUM(orders.sales) FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.region;

-- 5. úloha
SELECT products.product_name, SUM(orders.sales) AS SPOLU FROM products INNER JOIN orders ON orders.product_id = products.product_id GROUP BY products.product_name;

-- 7. úloha
SELECT customers.region, SUM(orders.sales) AS celkovy_predaj FROM orders INNER JOIN customers ON customers.customer_id = orders.customer_id GROUP BY customers.region;

-- 8. úloha
SELECT customers.customer_name, COUNT(orders.order_id) AS pocet_objednavok FROM customers LEFT JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.customer_id, customers.customer_name;

-- 9. úloha
SELECT products.category, AVG(orders.discount) AS priemerna_zlava FROM products INNER JOIN orders ON orders.product_id = products.product_id GROUP BY products.category;

-- 10. úloha
SELECT customers.customer_name, SUM(orders.sales) AS celkovy_nakup FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.customer_id, customers.customer_name HAVING SUM(orders.sales) > 2000;

-- 11. úloha
SELECT customers.region, SUM(orders.sales) AS celkovy_predaj, AVG(orders.discount) AS priemerna_zlava, COUNT(orders.order_id) AS pocet_objednavok FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.region;

-- 12. úloha
SELECT customers.region, SUM(CASE WHEN orders.sales > 1000 THEN 1 ELSE 0 END) AS high_value, SUM(CASE WHEN orders.sales <= 1000 THEN 1 ELSE 0 END) AS low_value FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.region;

-- 13. úloha
SELECT customers.customer_name, SUM(orders.sales) AS celkovy_predaj, AVG(orders.discount) AS priemerna_zlava, COUNT(orders.order_id) AS pocet_objednavok, CASE WHEN SUM(orders.sales) > 2500 THEN 'VIP' ELSE 'REGULAR' END AS typ_zakaznika FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id GROUP BY customers.customer_id, customers.customer_name ORDER BY celkovy_predaj DESC;
