# TIME SERIES DATA

CREATE DATABASE time_series;
USE time_series;


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    product VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    sales NUMERIC(10,2)
);


INSERT INTO orders
(order_id, order_date, product, category, quantity, sales)
VALUES
(1, '2026-01-05', 'Laptop', 'Electronics', 2, 120000),
(2, '2026-01-10', 'Mouse', 'Electronics', 5, 7500),
(3, '2026-01-15', 'Keyboard', 'Electronics', 3, 15000),
(4, '2026-01-20', 'Monitor', 'Electronics', 2, 30000),
(5, '2026-02-03', 'Laptop', 'Electronics', 3, 180000),
(6, '2026-02-08', 'Mouse', 'Electronics', 8, 12000),
(7, '2026-02-14', 'Keyboard', 'Electronics', 5, 25000),
(8, '2026-02-22', 'Monitor', 'Electronics', 3, 45000),
(9, '2026-03-04', 'Laptop', 'Electronics', 4, 240000),
(10, '2026-03-09', 'Mouse', 'Electronics', 10, 15000),
(11, '2026-03-16', 'Keyboard', 'Electronics', 6, 30000),
(12, '2026-03-25', 'Monitor', 'Electronics', 4, 60000),
(13, '2026-04-05', 'Laptop', 'Electronics', 5, 300000),
(14, '2026-04-11', 'Mouse', 'Electronics', 12, 18000),
(15, '2026-04-18', 'Keyboard', 'Electronics', 8, 40000),
(16, '2026-04-26', 'Monitor', 'Electronics', 5, 75000),
(17, '2026-05-03', 'Laptop', 'Electronics', 4, 240000),
(18, '2026-05-10', 'Mouse', 'Electronics', 15, 22500),
(19, '2026-05-17', 'Keyboard', 'Electronics', 10, 50000),
(20, '2026-05-24', 'Monitor', 'Electronics', 6, 90000);

-- BASIC TIME-SERIES QUERIES

-- 1. Display all records

SELECT * FROM orders;

-- 2. Display orders in date order

SELECT * FROM orders
ORDER BY order_date;


-- 3. Display order date and sales

SELECT
    order_date,
    sales
FROM orders
ORDER BY order_date;

-- 4. Find total sales

SELECT SUM(sales) AS total_sales
FROM orders;

-- 5. Find average sales

SELECT AVG(sales) AS average_sales
FROM orders;

-- 6. Find minimum sales

SELECT MIN(sales) AS minimum_sales
FROM orders;

-- 7. Find maximum sales

SELECT MAX(sales) AS maximum_sales
FROM orders;

-- 8. Count total orders

SELECT COUNT(*) AS total_orders
FROM orders;

-- 9. Find sales between two dates

SELECT * FROM orders
WHERE order_date BETWEEN '2026-01-01' AND '2026-03-31'
ORDER BY order_date;

-- 10. Find orders from February

SELECT * FROM orders
WHERE order_date >= '2026-02-01'
  AND order_date < '2026-03-01'
ORDER BY order_date;

-- DATE FUNCTIONS

-- 11. Extract year

SELECT
    order_date,
    EXTRACT(YEAR FROM order_date) AS year
FROM orders;

-- 12. Extract month

SELECT
    order_date,
    EXTRACT(MONTH FROM order_date) AS month
FROM orders;

-- 13. Extract day

SELECT
    order_date,
    EXTRACT(DAY FROM order_date) AS day
FROM orders;

-- 14. Extract year, month and day

SELECT
    order_date,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(DAY FROM order_date) AS day
FROM orders;

-- INTERMEDIATE TIME-SERIES QUERIES

-- 15. Daily sales

SELECT
    order_date,
    SUM(sales) AS daily_sales
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- 16. Daily order count

SELECT
    order_date,
    COUNT(*) AS daily_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- 17. Monthly sales
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS monthly_sales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;


-- 18. Monthly order count
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 19. Monthly average sales
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(AVG(sales), 2) AS average_sales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 20. Monthly quantity sold
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(quantity) AS total_quantity
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 21. Quarterly sales
SELECT
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    SUM(sales) AS quarterly_sales
FROM orders
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY year, quarter;

-- 22. Yearly sales
SELECT
    YEAR(order_date) AS year,
    SUM(sales) AS yearly_sales
FROM orders
GROUP BY YEAR(order_date)
ORDER BY year;

-- 23. Monthly sales by product
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    product,
    SUM(sales) AS total_sales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m'), product
ORDER BY month, product;

-- 24. Monthly sales by category
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    category,
    SUM(sales) AS total_sales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m'), category
ORDER BY month, category;

-- 25. Highest-sales month
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS total_sales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY total_sales DESC
LIMIT 1;

-- 26. Lowest-sales month
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS total_sales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY total_sales
LIMIT 1;

-- 27. Previous month's sales using LAG
SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) AS monthly_sales
ORDER BY month;

-- 28. Next month's sales using LEAD
SELECT
    month,
    total_sales,
    LEAD(total_sales) OVER (ORDER BY month) AS next_month_sales
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) AS monthly_sales
ORDER BY month;

-- 29. Month-over-month sales change
SELECT
    month,
    total_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY month) AS sales_change
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) AS monthly_sales
ORDER BY month;

-- 30. Running total
SELECT
    month,
    total_sales,
    SUM(total_sales) OVER (ORDER BY month) AS running_total
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) AS monthly_sales
ORDER BY month;


-- 31. Three-month moving average
SELECT
    month,
    total_sales,
    ROUND(
        AVG(total_sales) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS three_month_moving_average
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) AS monthly_sales
ORDER BY month;


-- 32. Previous month's sales for each product
SELECT
    month,
    product,
    total_sales,
    LAG(total_sales) OVER (
        PARTITION BY product
        ORDER BY month
    ) AS previous_product_sales
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        product,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m'), product
) AS product_sales
ORDER BY product, month;


-- 33. Running total for each product
SELECT
    month,
    product,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY product
        ORDER BY month
    ) AS product_running_total
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        product,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m'), product
) AS product_sales
ORDER BY product, month;

-- 34. Rank months based on sales
SELECT
    month,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) AS monthly_sales
ORDER BY sales_rank;

-- 35. Rank products based on total sales
SELECT
    product,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS product_rank
FROM (
    SELECT
        product,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY product
) AS product_sales
ORDER BY product_rank;


-- 36. Monthly sales with previous and next month
SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS previous_month,
    LEAD(total_sales) OVER (ORDER BY month) AS next_month
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) AS monthly_sales
ORDER BY month;


