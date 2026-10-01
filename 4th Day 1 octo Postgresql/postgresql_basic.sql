-- DAY 4: POSTGRESQL / SQL
-- Employee Management Practice


-- 1. Check PostgreSQL version
SELECT version();


-- 2. Create schema
CREATE SCHEMA IF NOT EXISTS organization;



-- 3. Create departments table
CREATE TABLE IF NOT EXISTS organization.departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);


-- 4. Create employees table
CREATE TABLE IF NOT EXISTS organization.employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    department_id INT,
    salary NUMERIC(10,2),
    city VARCHAR(50),
    joining_date DATE,
    is_active BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (department_id)
    REFERENCES organization.departments(department_id)
);


-- 5. Insert departments
INSERT INTO organization.departments (department_name)
VALUES
('Development'),
('Recruitment'),
('Accounts'),
('Sales');


-- 6. Insert employees
INSERT INTO organization.employees
(employee_name, email, department_id, salary, city, joining_date)
VALUES
('Riya', 'riya@gmail.com', 1, 72000, 'Pune', '2022-04-15'),
('Arjun', 'arjun@gmail.com', 2, 58000, 'Mumbai', '2023-02-20'),
('Vikas', 'vikas@gmail.com', 1, 88000, 'Bangalore', '2021-07-12'),
('Meena', 'meena@gmail.com', 3, 68000, 'Kolhapur', '2024-01-18'),
('Sahil', 'sahil@gmail.com', 1, 95000, 'Mumbai', '2020-09-25'),
('Kavya', 'kavya@gmail.com', 4, 63000, 'Pune', '2023-05-10'),
('Nikhil', 'nikhil@gmail.com', 3, 77000, 'Bangalore', '2022-11-30'),
('Aarti', 'aarti@gmail.com', 2, 61000, 'Kolhapur', '2024-05-16');


-- 7. Display all employees
SELECT *
FROM organization.employees;


-- 8. Select specific columns
SELECT employee_name, salary, city
FROM organization.employees;


-- 9. WHERE
SELECT *
FROM organization.employees
WHERE salary > 70000;


-- 10. AND
SELECT *
FROM organization.employees
WHERE salary > 70000
AND city = 'Mumbai';


-- 11. OR
SELECT *
FROM organization.employees
WHERE city = 'Pune'
OR city = 'Bangalore';


-- 12. AND with multiple conditions
SELECT *
FROM organization.employees
WHERE salary > 65000
AND city = 'Pune'
AND is_active = TRUE;


-- 13. OR with multiple conditions
SELECT *
FROM organization.employees
WHERE salary > 90000
OR city = 'Kolhapur';


-- 14. BETWEEN
SELECT *
FROM organization.employees
WHERE salary BETWEEN 60000 AND 80000;


-- 15. BETWEEN with age-like salary range
SELECT employee_name, salary
FROM organization.employees
WHERE salary BETWEEN 70000 AND 90000;


-- 16. IN
SELECT *
FROM organization.employees
WHERE city IN ('Pune', 'Mumbai');


-- 17. IN with departments
SELECT *
FROM organization.employees
WHERE department_id IN (1, 3);


-- 18. NOT IN
SELECT *
FROM organization.employees
WHERE city NOT IN ('Mumbai');


-- 19. LIKE
SELECT *
FROM organization.employees
WHERE employee_name LIKE 'A%';


-- 20. LIKE - names ending with a
SELECT *
FROM organization.employees
WHERE employee_name LIKE '%a';


-- 21. LIKE - names containing 'i'
SELECT *
FROM organization.employees
WHERE employee_name LIKE '%i%';


-- 22. PostgreSQL ILIKE
SELECT *
FROM organization.employees
WHERE employee_name ILIKE 'r%';


-- 23. ORDER BY ascending
SELECT *
FROM organization.employees
ORDER BY salary ASC;


-- 24. ORDER BY descending
SELECT *
FROM organization.employees
ORDER BY salary DESC;


-- 25. ORDER BY city
SELECT *
FROM organization.employees
ORDER BY city ASC;


-- 26. LIMIT
SELECT *
FROM organization.employees
ORDER BY salary DESC
LIMIT 3;


-- 27. LIMIT with WHERE
SELECT *
FROM organization.employees
WHERE city = 'Pune'
ORDER BY salary DESC
LIMIT 2;


-- 28. OFFSET
SELECT *
FROM organization.employees
ORDER BY salary DESC
OFFSET 2;


-- 29. LIMIT with OFFSET
SELECT *
FROM organization.employees
ORDER BY salary DESC
LIMIT 3 OFFSET 2;


-- 30. DISTINCT
SELECT DISTINCT city
FROM organization.employees;


-- 31. DISTINCT departments
SELECT DISTINCT department_id
FROM organization.employees;


-- 32. COUNT
SELECT COUNT(*) AS total_employees
FROM organization.employees;


-- 33. COUNT with condition
SELECT COUNT(*) AS active_employees
FROM organization.employees
WHERE is_active = TRUE;


-- 34. SUM
SELECT SUM(salary) AS total_salary
FROM organization.employees;


-- 35. MIN
SELECT MIN(salary) AS minimum_salary
FROM organization.employees;


-- 36. MAX
SELECT MAX(salary) AS maximum_salary
FROM organization.employees;


-- 37. AVG
SELECT AVG(salary) AS average_salary
FROM organization.employees;


-- 38. All aggregate functions
SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM organization.employees;


-- 39. GROUP BY department
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM organization.employees
GROUP BY department_id;


-- 40. GROUP BY city
SELECT
    city,
    COUNT(*) AS employee_count
FROM organization.employees
GROUP BY city;


-- 41. GROUP BY with SUM
SELECT
    department_id,
    SUM(salary) AS total_salary
FROM organization.employees
GROUP BY department_id;


-- 42. GROUP BY with AVG
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM organization.employees
GROUP BY department_id;


-- 43. GROUP BY with MIN and MAX
SELECT
    department_id,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM organization.employees
GROUP BY department_id;


-- 44. HAVING
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM organization.employees
GROUP BY department_id
HAVING COUNT(*) > 1;


-- 45. HAVING with AVG
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM organization.employees
GROUP BY department_id
HAVING AVG(salary) > 70000;


-- 46. GROUP BY + HAVING + ORDER BY
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM organization.employees
GROUP BY department_id
HAVING AVG(salary) > 65000
ORDER BY average_salary DESC;


-- 47. UPDATE salary
UPDATE organization.employees
SET salary = 76000
WHERE employee_id = 1;


-- 48. Update city
UPDATE organization.employees
SET city = 'Nashik'
WHERE employee_id = 2;


-- 49. Update multiple columns
UPDATE organization.employees
SET salary = 82000,
    city = 'Pune'
WHERE employee_id = 4;


-- 50. Check updated record
SELECT *
FROM organization.employees
WHERE employee_id = 1;


-- 51. DELETE one record
DELETE FROM organization.employees
WHERE employee_id = 8;

select * from organization.employees;

-- 52. DELETE using condition
DELETE FROM organization.employees
WHERE salary < 60000;


-- 53. Check remaining employees
SELECT *
FROM organization.employees;


-- 54. Basic INNER JOIN
SELECT
    e.employee_name,
    d.department_name,
    e.salary
FROM organization.employees e
INNER JOIN organization.departments d
ON e.department_id = d.department_id;


-- 55. Basic LEFT JOIN
SELECT
    e.employee_name,
    d.department_name
FROM organization.employees e
LEFT JOIN organization.departments d
ON e.department_id = d.department_id;


-- 56. JOIN with condition
SELECT
    e.employee_name,
    d.department_name,
    e.salary
FROM organization.employees e
JOIN organization.departments d
ON e.department_id = d.department_id
WHERE e.salary > 75000;


-- 57. JOIN with AND
SELECT
    e.employee_name,
    d.department_name,
    e.salary,
    e.city
FROM organization.employees e
JOIN organization.departments d
ON e.department_id = d.department_id
WHERE e.salary > 70000
AND e.city = 'Pune';


-- 58. JOIN with ORDER BY
SELECT
    e.employee_name,
    d.department_name,
    e.salary
FROM organization.employees e
JOIN organization.departments d
ON e.department_id = d.department_id
ORDER BY e.salary DESC;


-- 59. JOIN with GROUP BY
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM organization.departments d
LEFT JOIN organization.employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;


