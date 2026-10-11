-- Príprava databázy retail_sales
CREATE DATABASE retail_sales;

CREATE TABLE orders (
    order_id    VARCHAR(20)    PRIMARY KEY,
    customer_id VARCHAR(20)    NOT NULL,
    product_id  VARCHAR(20)    NOT NULL,
    order_date  DATE           NOT NULL,
    region      VARCHAR(20)    NOT NULL,
    category    VARCHAR(50)    NOT NULL,
    ship_mode   VARCHAR(30)    NOT NULL,
    sales       NUMERIC(10, 2) NOT NULL,
    profit      NUMERIC(10, 2) NOT NULL
);

ALTER DATABASE retail_sales SET datestyle TO 'ISO, MDY';

SELECT * FROM orders;

-- databáza: superstore

-- 8. úloha
CREATE OR REPLACE PROCEDURE get_customer_sales(p_customer_id VARCHAR(20))
LANGUAGE plpgsql
AS $procedure$
DECLARE
    v_total_sales NUMERIC(10,2);
BEGIN
    SELECT SUM(sales) INTO v_total_sales FROM orders WHERE customer_id = p_customer_id;
    RAISE NOTICE 'Zakaznik %: celkovy predaj %', p_customer_id, v_total_sales;
END;
$procedure$;

CALL get_customer_sales('C001');

-- 9. úloha
CREATE OR REPLACE PROCEDURE apply_regional_discount(region_name VARCHAR(50), discount_rate NUMERIC(5,2))
LANGUAGE plpgsql
AS $procedure$
BEGIN
    UPDATE orders SET sales = sales * (1 - discount_rate) WHERE customer_id IN (SELECT customer_id FROM customers WHERE region = region_name);
    RAISE NOTICE 'Zlava % bola aplikovana na region %', discount_rate, region_name;
END;
$procedure$;

CALL apply_regional_discount('West', 0.10);

-- 10. úloha
CREATE OR REPLACE PROCEDURE get_sales_between(start_date DATE, end_date DATE)
LANGUAGE plpgsql
AS $procedure$
DECLARE
    v_total_sales NUMERIC(10,2);
BEGIN
    SELECT SUM(sales) INTO v_total_sales FROM orders WHERE order_date BETWEEN start_date AND end_date;
    RAISE NOTICE 'Obdobie od % do %: celkovy predaj %', start_date, end_date, v_total_sales;
END;
$procedure$;

CALL get_sales_between('2024-01-01', '2024-03-31');
