-- DAY 5: JOINS & WINDOW FUNCTIONS
-- PostgreSQL Practice
-- Joins

-- 1. Create departments table
CREATE TABLE day5_hospital_departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- 2. Create staff table
-- manager_id is used later for SELF JOIN
CREATE TABLE day5_hospital_staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100),
    department_id INT,
    salary NUMERIC(10,2),
    city VARCHAR(50),
    manager_id INT
);

-- 3. Create services table
CREATE TABLE day5_hospital_services (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(100),
    department_id INT
);

-- 4. Insert departments
INSERT INTO day5_hospital_departments
(department_id, department_name)
VALUES
(11, 'Cardiology'),
(12, 'Neurology'),
(13, 'Pharmacy'),
(14, 'Radiology');

-- 5. Insert staff
INSERT INTO day5_hospital_staff
(staff_id, staff_name, department_id, salary, city, manager_id)
VALUES
(201, 'Meera', 11, 82000, 'Nashik', NULL),
(202, 'Arjun', 12, 68000, 'Nagpur', 201),
(203, 'Kavya', 11, 91000, 'Aurangabad', 201),
(204, 'Vivek', 13, 73000, 'Kolhapur', 207),
(205, 'Riya', 11, 96000, 'Nashik', 201),
(206, 'Sahil', 14, 71000, 'Pune', 208),
(207, 'Manoj', 13, 87000, 'Mumbai', NULL),
(208, 'Isha', 12, 69000, 'Pune', 201);

-- 6. Insert services
INSERT INTO day5_hospital_services
(service_id, service_name, department_id)
VALUES
(31, 'Heart Care Program', 11),
(32, 'Brain Health Program', 12),
(33, 'Medicine Management', 13),
(34, 'MRI Diagnostics', 14);

-- 7. View all tables
SELECT * FROM day5_hospital_departments;
SELECT * FROM day5_hospital_staff;
SELECT * FROM day5_hospital_services;

-- PART 1: JOINS

-- 8. INNER JOIN
-- Shows only staff who have a matching department
SELECT
    s.staff_name,
    d.department_name
FROM day5_hospital_staff s
INNER JOIN day5_hospital_departments d
ON s.department_id = d.department_id;

-- 9. LEFT JOIN
-- Shows all staff and their department if available
SELECT
    s.staff_name,
    d.department_name
FROM day5_hospital_staff s
LEFT JOIN day5_hospital_departments d
ON s.department_id = d.department_id;

-- 10. RIGHT JOIN
-- Shows all departments and matching staff
SELECT
    s.staff_name,
    d.department_name
FROM day5_hospital_staff s
RIGHT JOIN day5_hospital_departments d
ON s.department_id = d.department_id;

-- 11. FULL OUTER JOIN
-- Shows all staff and all departments
SELECT
    s.staff_name,
    d.department_name
FROM day5_hospital_staff s
FULL OUTER JOIN day5_hospital_departments d
ON s.department_id = d.department_id;

-- 12. CROSS JOIN
-- Creates every possible staff-department combination
SELECT
    s.staff_name,
    d.department_name
FROM day5_hospital_staff s
CROSS JOIN day5_hospital_departments d;

-- 13. SELF JOIN
-- Joins staff table with itself to find staff and manager
SELECT
    s.staff_name AS staff_member,
    m.staff_name AS manager
FROM day5_hospital_staff s
LEFT JOIN day5_hospital_staff m
ON s.manager_id = m.staff_id;

-- PART 2: JOINS WITH FILTERING AND SORTING

-- 14. JOIN with WHERE
-- Shows staff whose salary is greater than 75000
SELECT
    s.staff_name,
    d.department_name,
    s.salary
FROM day5_hospital_staff s
INNER JOIN day5_hospital_departments d
ON s.department_id = d.department_id
WHERE s.salary > 75000;

-- 15. JOIN with ORDER BY
-- Shows staff from highest to lowest salary
SELECT
    s.staff_name,
    d.department_name,
    s.salary
FROM day5_hospital_staff s
INNER JOIN day5_hospital_departments d
ON s.department_id = d.department_id
ORDER BY s.salary DESC;

-- 16. JOIN with GROUP BY
-- Counts staff in each department
SELECT
    d.department_name,
    COUNT(s.staff_id) AS staff_count
FROM day5_hospital_departments d
LEFT JOIN day5_hospital_staff s
ON d.department_id = s.department_id
GROUP BY d.department_name;

-- 17. Multiple-table JOIN
-- Joins staff, departments and services
SELECT
    s.staff_name,
    d.department_name,
    v.service_name,
    s.salary
FROM day5_hospital_staff s
INNER JOIN day5_hospital_departments d
ON s.department_id = d.department_id
INNER JOIN day5_hospital_services v
ON d.department_id = v.department_id;

-- 18. Multiple-table JOIN with WHERE
-- Shows Cardiology staff and their service
SELECT
    s.staff_name,
    d.department_name,
    v.service_name
FROM day5_hospital_staff s
INNER JOIN day5_hospital_departments d
ON s.department_id = d.department_id
INNER JOIN day5_hospital_services v
ON d.department_id = v.department_id
WHERE d.department_name = 'Cardiology';

-- 19. JOIN with Multiple Conditions
-- Shows staff from Pune with their department
SELECT
    s.staff_name,
    s.city,
    d.department_name
FROM day5_hospital_staff s
INNER JOIN day5_hospital_departments d
ON s.department_id = d.department_id
AND s.city = 'Pune';

-- 20. JOIN with Salary Condition
-- Shows staff whose salary is greater than 75000
SELECT
    s.staff_name,
    d.department_name,
    s.salary
FROM day5_hospital_staff s
INNER JOIN day5_hospital_departments d
ON s.department_id = d.department_id
WHERE s.salary > 75000;

-- 21. LEFT JOIN with GROUP BY
-- Shows total salary paid by each department
SELECT
    d.department_name,
    COALESCE(SUM(s.salary), 0) AS total_salary
FROM day5_hospital_departments d
LEFT JOIN day5_hospital_staff s
ON d.department_id = s.department_id
GROUP BY d.department_name;

-- 22. LEFT JOIN with AVG()
-- Shows average salary of staff in each department
SELECT
    d.department_name,
    AVG(s.salary) AS average_salary
FROM day5_hospital_departments d
LEFT JOIN day5_hospital_staff s
ON d.department_id = s.department_id
GROUP BY d.department_name;

-- 23. LEFT JOIN with COUNT()
-- Shows number of staff in each department
SELECT
    d.department_name,
    COUNT(s.staff_id) AS total_staff
FROM day5_hospital_departments d
LEFT JOIN day5_hospital_staff s
ON d.department_id = s.department_id
GROUP BY d.department_name;

-- 24. JOIN with GROUP BY and HAVING
-- Shows departments having more than 1 staff member
SELECT
    d.department_name,
    COUNT(s.staff_id) AS staff_count
FROM day5_hospital_departments d
INNER JOIN day5_hospital_staff s
ON d.department_id = s.department_id
GROUP BY d.department_name
HAVING COUNT(s.staff_id) > 1;

-- 25. JOIN to Find Highest Salary Staff
-- Shows staff with the highest salary
SELECT
    s.staff_name,
    d.department_name,
    s.salary
FROM day5_hospital_staff s
INNER JOIN day5_hospital_departments d
ON s.department_id = d.department_id
WHERE s.salary = (
    SELECT MAX(salary)
    FROM day5_hospital_staff
);

