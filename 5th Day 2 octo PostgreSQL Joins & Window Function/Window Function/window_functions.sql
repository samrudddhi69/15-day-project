-- Window Functions

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    joining_date DATE
);

INSERT INTO employees VALUES
(101, 'Amit', 'IT', 60000, '2022-01-10'),
(102, 'Priya', 'HR', 50000, '2021-03-15'),
(103, 'Rahul', 'IT', 75000, '2020-06-20'),
(104, 'Sneha', 'Finance', 65000, '2022-08-12'),
(105, 'Vikas', 'HR', 55000, '2023-01-18'),
(106, 'Neha', 'Finance', 70000, '2021-11-05'),
(107, 'Rohan', 'IT', 80000, '2019-04-25'),
(108, 'Pooja', 'HR', 60000, '2020-09-10'),
(109, 'Karan', 'Finance', 60000, '2023-05-14'),
(110, 'Anjali', 'IT', 65000, '2022-12-01');


-- 1. OVER()
SELECT
    employee_name,
    salary,
    AVG(salary) OVER() AS average_salary
FROM employees;


-- 2. ROW_NUMBER()
SELECT
    employee_name,
    salary,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM employees;


-- 3. RANK()
SELECT
    employee_name,
    salary,
    RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM employees;


-- 4. DENSE_RANK()
SELECT
    employee_name,
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_salary_rank
FROM employees;


-- 5. COUNT() OVER()
SELECT
    employee_name,
    department,
    COUNT(*) OVER() AS total_employees
FROM employees;


-- 6. SUM() OVER()
SELECT
    employee_name,
    salary,
    SUM(salary) OVER() AS total_salary
FROM employees;


-- 7. MIN() OVER()
SELECT
    employee_name,
    salary,
    MIN(salary) OVER() AS minimum_salary
FROM employees;


-- 8. MAX() OVER()
SELECT
    employee_name,
    salary,
    MAX(salary) OVER() AS maximum_salary
FROM employees;


-- 9. ROW_NUMBER() BY DEPARTMENT
SELECT
    employee_name,
    department,
    salary,
    ROW_NUMBER() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_row_number
FROM employees;


-- 10. RANK() BY DEPARTMENT
SELECT
    employee_name,
    department,
    salary,
    RANK() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_rank
FROM employees;


-- 11. DENSE_RANK() BY DEPARTMENT
SELECT
    employee_name,
    department,
    salary,
    DENSE_RANK() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_dense_rank
FROM employees;


-- 12. AVERAGE SALARY BY DEPARTMENT
SELECT
    employee_name,
    department,
    salary,
    AVG(salary) OVER(
        PARTITION BY department
    ) AS department_average_salary
FROM employees;


-- 13. TOTAL SALARY BY DEPARTMENT
SELECT
    employee_name,
    department,
    salary,
    SUM(salary) OVER(
        PARTITION BY department
    ) AS department_total_salary
FROM employees;


-- 14. EMPLOYEE COUNT BY DEPARTMENT
SELECT
    employee_name,
    department,
    COUNT(*) OVER(
        PARTITION BY department
    ) AS department_employee_count
FROM employees;


-- 15. LAG()
SELECT
    employee_name,
    salary,
    LAG(salary) OVER(
        ORDER BY salary
    ) AS previous_salary
FROM employees;


-- 16. LEAD()
SELECT
    employee_name,
    salary,
    LEAD(salary) OVER(
        ORDER BY salary
    ) AS next_salary
FROM employees;


-- 17. SALARY DIFFERENCE WITH PREVIOUS SALARY
SELECT
    employee_name,
    salary,
    LAG(salary) OVER(
        ORDER BY salary
    ) AS previous_salary,
    salary - LAG(salary) OVER(
        ORDER BY salary
    ) AS salary_difference
FROM employees;


-- 18. FIRST_VALUE()
SELECT
    employee_name,
    salary,
    FIRST_VALUE(salary) OVER(
        ORDER BY salary DESC
    ) AS highest_salary
FROM employees;


-- 19. LAST_VALUE()
SELECT
    employee_name,
    salary,
    LAST_VALUE(salary) OVER(
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS lowest_salary
FROM employees;


-- 20. RUNNING TOTAL
SELECT
    employee_name,
    salary,
    SUM(salary) OVER(
        ORDER BY employee_id
    ) AS running_total_salary
FROM employees;


-- 21. RUNNING AVERAGE
SELECT
    employee_name,
    salary,
    AVG(salary) OVER(
        ORDER BY employee_id
    ) AS running_average_salary
FROM employees;


-- 22. RUNNING MAXIMUM
SELECT
    employee_name,
    salary,
    MAX(salary) OVER(
        ORDER BY employee_id
    ) AS running_max_salary
FROM employees;


-- 23. TOP 1 EMPLOYEE FROM EACH DEPARTMENT
SELECT *
FROM (
    SELECT
        employee_name,
        department,
        salary,
        ROW_NUMBER() OVER(
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
) AS ranked_employees
WHERE rn = 1;


-- 24. TOP 2 EMPLOYEES FROM EACH DEPARTMENT
SELECT *
FROM (
    SELECT
        employee_name,
        department,
        salary,
        ROW_NUMBER() OVER(
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
) AS ranked_employees
WHERE rn <= 2;


-- 25. EMPLOYEES ABOVE DEPARTMENT AVERAGE
SELECT *
FROM (
    SELECT
        employee_name,
        department,
        salary,
        AVG(salary) OVER(
            PARTITION BY department
        ) AS department_avg
    FROM employees
) AS employee_data
WHERE salary > department_avg;


-- 26. PREVIOUS EMPLOYEE WITHIN DEPARTMENT
SELECT
    employee_name,
    department,
    salary,
    LAG(salary) OVER(
        PARTITION BY department
        ORDER BY salary
    ) AS previous_department_salary
FROM employees;


-- 27. NEXT EMPLOYEE WITHIN DEPARTMENT
SELECT
    employee_name,
    department,
    salary,
    LEAD(salary) OVER(
        PARTITION BY department
        ORDER BY salary
    ) AS next_department_salary
FROM employees;


-- 28. RUNNING TOTAL BY DEPARTMENT
SELECT
    employee_name,
    department,
    salary,
    SUM(salary) OVER(
        PARTITION BY department
        ORDER BY salary
    ) AS department_running_total
FROM employees;


-- 29. RUNNING AVERAGE BY DEPARTMENT
SELECT
    employee_name,
    department,
    salary,
    AVG(salary) OVER(
        PARTITION BY department
        ORDER BY salary
    ) AS department_running_average
FROM employees;