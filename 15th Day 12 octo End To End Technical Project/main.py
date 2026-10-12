
from database import create_connection

def show_doctors():
    connection = create_connection()

    if connection:
        cursor = connection.cursor()
        cursor.execute("""
            SELECT d.doctor_name, d.specialization,
                   dep.department_name, d.salary
            FROM doctors d
            INNER JOIN departments dep
                ON d.department_id = dep.department_id
        """)

        print("\n--- Doctor Details ---")
        for row in cursor.fetchall():
            print(row)

        cursor.close()
        connection.close()


def show_patients():
    connection = create_connection()

    if connection:
        cursor = connection.cursor()
        cursor.execute("""
            SELECT patient_id, patient_name, age, gender, city
            FROM patients
        """)

        print("\n--- Patient Details ---")
        for row in cursor.fetchall():
            print(row)

        cursor.close()
        connection.close()


def show_appointments():
    connection = create_connection()

    if connection:
        cursor = connection.cursor()
        cursor.execute("""
            SELECT p.patient_name, d.doctor_name,
                   a.appointment_date, a.status
            FROM appointments a
            INNER JOIN patients p
                ON a.patient_id = p.patient_id
            INNER JOIN doctors d
                ON a.doctor_id = d.doctor_id
        """)

        print("\n--- Appointment Details ---")
        for row in cursor.fetchall():
            print(row)

        cursor.close()
        connection.close()


while True:
    print("\n===== HOSPITAL MANAGEMENT SYSTEM =====")
    print("1. View Doctors")
    print("2. View Patients")
    print("3. View Appointments")
    print("4. Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        show_doctors()
    elif choice == "2":
        show_patients()
    elif choice == "3":
        show_appointments()
    elif choice == "4":
        print("Thank you for using Hospital Management System!")
        break
    else:
        print("Invalid choice. Please enter 1 to 4.")


