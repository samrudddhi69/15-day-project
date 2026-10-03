-- POSTGRESQL - INDEXING & QUERY PERFORMANCE

-- INDEXING

-- 1. INDEX FUNDAMENTALS
-- customers: customer_id, customer_name, city
-- products: product_id, product_name, category, price
-- orders: order_id, customer_id, product_id, order_date, quantity

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50) );

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2) );

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id) );

INSERT INTO customers
(customer_id, customer_name, city)
VALUES
(1, 'Aakanksha', 'Mumbai'),
(2, 'Rahul', 'Pune'),
(3, 'Sneha', 'Kolhapur'),
(4, 'Amit', 'Mumbai'),
(5, 'Priya', 'Delhi'),
(6, 'Rohit', 'Pune'),
(7, 'Neha', 'Mumbai'),
(8, 'Akshay', 'Bangalore'),
(9, 'Pooja', 'Delhi'),
(10, 'Vikas', 'Hyderabad');

INSERT INTO products
(product_id, product_name, category, price)
VALUES
(1, 'Laptop', 'Electronics', 55000.00),
(2, 'Mobile', 'Electronics', 25000.00),
(3, 'Tablet', 'Electronics', 30000.00),
(4, 'Headphones', 'Accessories', 2500.00),
(5, 'Keyboard', 'Accessories', 1500.00),
(6, 'Mouse', 'Accessories', 800.00),
(7, 'Monitor', 'Electronics', 18000.00),
(8, 'Printer', 'Electronics', 12000.00),
(9, 'Smart Watch', 'Wearables', 7000.00),
(10, 'Power Bank', 'Accessories', 1800.00);

INSERT INTO orders
(order_id, customer_id, product_id, order_date, quantity)
VALUES
(1, 1, 1, '2024-01-10', 1),
(2, 2, 2, '2024-01-15', 2),
(3, 3, 4, '2024-01-20', 1),
(4, 4, 3, '2024-02-01', 1),
(5, 5, 5, '2024-02-05', 3),
(6, 1, 6, '2024-02-10', 2),
(7, 5, 7, '2024-02-01', 1),
(8, 6, 8, '2024-02-15', 1),
(9, 7, 9, '2024-03-01', 2),
(10, 8, 10, '2024-03-05', 2),
(11, 9, 2, '2024-03-10', 1),
(12, 10, 1, '2024-03-15', 1),
(13, 1, 3, '2024-04-01', 1),
(14, 4, 4, '2024-04-05', 2),
(15, 7, 5, '2024-04-10', 3);

SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM customers;

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'customers';

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'products';

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'orders';

EXPLAIN SELECT * FROM customers
WHERE customer_id = 5;

EXPLAIN SELECT * FROM products
WHERE product_id = 3;

EXPLAIN SELECT * FROM orders
WHERE order_id = 7;

CREATE UNIQUE INDEX idx_unique_customer_name
ON customers(customer_name);

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'customers';

DROP INDEX IF EXISTS idx_unique_customer_name;

CREATE INDEX idx_customer_city_name
ON customers(city, customer_name);

SELECT * FROM customers
WHERE city = 'Mumbai'
AND customer_name = 'Neha';

EXPLAIN SELECT * FROM customers
WHERE city = 'Mumbai'
AND customer_name = 'Neha';

CREATE INDEX idx_customer_city_covering
ON customers(city)
INCLUDE (customer_name);

EXPLAIN SELECT customer_name, city
FROM customers
WHERE city = 'Mumbai';

CREATE INDEX idx_product_fulltext
ON products
USING GIN (
    to_tsvector('english', product_name) );

SELECT * FROM products
WHERE to_tsvector('english', product_name)
      @@ plainto_tsquery('english', 'Laptop');

SELECT * FROM products
WHERE to_tsvector('english', product_name)
      @@ plainto_tsquery('english', 'Mobile');

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'products';

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(DISTINCT city) AS unique_cities
FROM customers;

SELECT
    COUNT(DISTINCT city)::DECIMAL / NULLIF(COUNT(*), 0)
    AS city_selectivity
FROM customers;

SELECT
    COUNT(DISTINCT customer_id)::DECIMAL / NULLIF(COUNT(*), 0)
    AS customer_id_selectivity
FROM customers;

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_orders_product_id
ON orders(product_id);

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'orders';

CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);

SELECT * FROM orders
WHERE customer_id = 5
AND order_date = '2024-02-01';

EXPLAIN SELECT * FROM orders
WHERE customer_id = 5
AND order_date = '2024-02-01';

EXPLAIN SELECT * FROM customers
WHERE city = 'Mumbai';

EXPLAIN SELECT * FROM customers
WHERE customer_id = 5;

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE customer_id = 5;

EXPLAIN
SELECT
    c.customer_name,
    o.order_date,
    o.quantity
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;

EXPLAIN SELECT * FROM customers
WHERE customer_name LIKE '%a%';

EXPLAIN SELECT * FROM customers
WHERE customer_id = 5;

SELECT
    c.customer_name,
    p.product_name,
    o.quantity
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id;

EXPLAIN
SELECT
    c.customer_name,
    p.product_name,
    o.quantity
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN products p
    ON o.product_id = p.product_id;

SELECT customer_name FROM customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM orders );

EXPLAIN SELECT customer_name
FROM customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM orders );

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE EXISTS
(
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id );

EXPLAIN
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
WHERE EXISTS
(
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id );

EXPLAIN
SELECT customer_name
FROM customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM orders );

EXPLAIN
SELECT DISTINCT
    c.customer_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;

EXPLAIN SELECT * FROM customers
WHERE customer_id = 5;

EXPLAIN SELECT * FROM customers
WHERE city = 'Mumbai';

EXPLAIN SELECT * FROM orders
WHERE customer_id = 5
AND order_date = '2024-02-01';

EXPLAIN SELECT * FROM orders
WHERE customer_id = 5;

EXPLAIN SELECT * FROM orders
WHERE customer_id = 5
AND order_date = '2024-02-01';

EXPLAIN SELECT * FROM orders
WHERE order_date = '2024-02-01';

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'customers';

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'products';

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'orders';