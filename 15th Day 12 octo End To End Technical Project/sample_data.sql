USE hospital_management_system;

-- Sample Departments
INSERT INTO departments
(department_id, department_name, location)
VALUES
(1, 'Cardiology', 'Floor 1'),
(2, 'Neurology', 'Floor 2'),
(3, 'Pharmacy', 'Floor 1'),
(4, 'Radiology', 'Floor 3'),
(5, 'Orthopedics', 'Floor 2');

-- Sample Doctors
INSERT INTO doctors
(doctor_id, doctor_name, specialization, department_id, salary)
VALUES
(1, 'Dr. Amit Sharma', 'Cardiologist', 1, 90000),
(2, 'Dr. Priya Patil', 'Neurologist', 2, 85000),
(3, 'Dr. Rahul Desai', 'Pharmacologist', 3, 65000),
(4, 'Dr. Sneha Joshi', 'Radiologist', 4, 80000),
(5, 'Dr. Neha Kulkarni', 'Orthopedic', 5, 75000),
(6, 'Dr. Karan Shah', 'Cardiologist', 1, 95000);

-- Sample Patients
INSERT INTO patients
(patient_id, patient_name, age, gender, phone, city)
VALUES
(1, 'Aarav Patil', 28, 'Male', '9876543210', 'Kolhapur'),
(2, 'Priya Sharma', 35, 'Female', '9876543211', 'Pune'),
(3, 'Rahul Desai', 42, 'Male', '9876543212', 'Mumbai'),
(4, 'Sneha Joshi', 24, 'Female', '9876543213', 'Sangli'),
(5, 'Neha Kulkarni', 50, 'Female', '9876543214', 'Kolhapur');

-- Sample Appointments
INSERT INTO appointments
(appointment_id, patient_id, doctor_id,
 appointment_date, appointment_time, status)
VALUES
(1, 1, 1, '2026-10-13', '10:00:00', 'Scheduled'),
(2, 2, 2, '2026-10-13', '11:30:00', 'Completed'),
(3, 3, 3, '2026-10-14', '12:00:00', 'Scheduled'),
(4, 4, 4, '2026-10-14', '14:00:00', 'Cancelled'),
(5, 5, 5, '2026-10-15', '15:30:00', 'Scheduled');
