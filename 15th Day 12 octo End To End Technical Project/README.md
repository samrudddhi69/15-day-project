# Hospital Management System

## Project Overview
A database-driven Hospital Management System developed using Python and MySQL to manage hospital departments, doctors, patients, and appointments.

## Technologies Used
- Python
- MySQL
- MySQL Connector/Python
- SQL

## Database Tables
- Departments
- Doctors
- Patients
- Appointments

## Features
- View doctor details with department information using SQL JOINs.
- View patient details.
- View appointment details.
- Retrieve and display MySQL data using Python.
- Use a menu-driven interface to navigate hospital records.

## SQL Concepts Practiced
- CREATE TABLE and INSERT
- SELECT, WHERE, ORDER BY
- INNER JOIN, LEFT JOIN, RIGHT JOIN
- Aggregate functions and GROUP BY
- HAVING and subqueries
- CTE and window functions
- Views, indexes, UPDATE, and DELETE

## Project Outcome
Successfully connected Python with MySQL and developed a menu-driven application to display hospital doctors, patients, and appointment records.

## How to Run
1. Install the dependency:
   `pip install mysql-connector-python`
2. Configure the MySQL credentials in `database.py`.
3. Ensure the `hospital_management_system` database and its tables exist.
4. Run the application:
   `python main.py`