import requests

url = "http://127.0.0.1:5000/students"

data = {
    "name": "Aarti",
    "course": "B.Pharm",
    "marks": 89
}

headers = {
    "Content-Type": "application/json"
}

response = requests.post(
    url,
    json=data,
    headers=headers
)

print("Status Code:", response.status_code)
print("Request Headers:", headers)
print("Request Body:", data)
print("Response Headers:", response.headers)
print("Response Body:", response.json())