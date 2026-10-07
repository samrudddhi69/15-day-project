import requests

BASE_URL = "http://127.0.0.1:5000"


# GET ALL APPOINTMENTS

response = requests.get(
    f"{BASE_URL}/appointments"
)

print("\nGET ALL APPOINTMENTS")
print("Status:", response.status_code)
print(response.json())


# GET APPOINTMENT BY ID

response = requests.get(
    f"{BASE_URL}/appointments/101"
)

print("\nGET APPOINTMENT BY ID")
print("Status:", response.status_code)
print(response.json())


# SEARCH BY DEPARTMENT

response = requests.get(
    f"{BASE_URL}/appointments/search",
    params={
        "department": "Cardiology"
    }
)

print("\nSEARCH BY DEPARTMENT")
print("Status:", response.status_code)
print(response.json())


# POST - CREATE APPOINTMENT

new_appointment = {
    "patient_name": "Maya Desai",
    "doctor_name": "Dr. Arjun Mehta",
    "department": "General Medicine",
    "appointment_date": "2026-10-12",
    "status": "Scheduled"
}

response = requests.post(
    f"{BASE_URL}/appointments",
    json=new_appointment
)

print("\nPOST - CREATE")
print("Status:", response.status_code)
print(response.json())


# PUT - COMPLETE UPDATE

updated_appointment = {
    "patient_name": "Aarav Joshi",
    "doctor_name": "Dr. Arjun Mehta",
    "department": "General Medicine",
    "appointment_date": "2026-10-15",
    "status": "Completed"
}

response = requests.put(
    f"{BASE_URL}/appointments/102",
    json=updated_appointment
)

print("\nPUT - COMPLETE UPDATE")
print("Status:", response.status_code)
print(response.json())


# PATCH - PARTIAL UPDATE

patch_data = {
    "status": "Cancelled"
}

response = requests.patch(
    f"{BASE_URL}/appointments/103",
    json=patch_data
)

print("\nPATCH - PARTIAL UPDATE")
print("Status:", response.status_code)
print(response.json())


# DELETE

response = requests.delete(
    f"{BASE_URL}/appointments/104"
)

print("\nDELETE")
print("Status:", response.status_code)
print(response.json())