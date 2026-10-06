import requests

url = "http://127.0.0.1:5000/students/filter"

params = {
    "min_marks": 85
}

response = requests.get(url, params=params)

print("Status Code:", response.status_code)
print("Response:", response.json())