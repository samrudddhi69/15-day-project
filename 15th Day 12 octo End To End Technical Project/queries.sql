```sql
USE hospital_management_system;

-- 1. Display all doctors with their departments
SELECT
    d.doctor_id,
    d.doctor_name,
    d.specialization,
    dep.department_name,
    d.salary
FROM doctors d
INNER JOIN departments dep
    ON d.department_id = dep.department_id;

-- 2. Display all patients
SELECT *
FROM patients;

-- 3. Display appointments with patient and doctor names
SELECT
    a.appointment_id,
    p.patient_name,
    d.doctor_name,
    a.appointment_date,
    a.appointment_time,
    a.status
FROM appointments a
INNER JOIN patients p
    ON a.patient_id = p.patient_id
INNER JOIN doctors d
    ON a.doctor_id = d.doctor_id;

-- 4. Count appointments by status
SELECT
    status,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY status;

-- 5. Count patients by city
SELECT
    city,
    COUNT(*) AS total_patients
FROM patients
GROUP BY city;

-- 6. Average doctor salary by department
SELECT
    dep.department_name,
    AVG(d.salary) AS average_salary
FROM doctors d
INNER JOIN departments dep
    ON d.department_id = dep.department_id
GROUP BY dep.department_name;

-- 7. Departments with average salary above 75000
SELECT
    dep.department_name,
    AVG(d.salary) AS average_salary
FROM doctors d
INNER JOIN departments dep
    ON d.department_id = dep.department_id
GROUP BY dep.department_name
HAVING AVG(d.salary) > 75000;

-- 8. Doctors earning above the average salary
SELECT
    doctor_name,
    salary
FROM doctors
WHERE salary > (
    SELECT AVG(salary)
    FROM doctors
);

-- 9. Find the highest-paid doctor
SELECT
    doctor_name,
    salary
FROM doctors
ORDER BY salary DESC
LIMIT 1;
```