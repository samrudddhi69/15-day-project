# 1. BASIC LIST COMPREHENSION

# Create a list of doubled values

values = [3, 7, 11, 15, 19, 23]

doubled = [x * 2 for x in values]

print("Doubled Values:", doubled)


# 2. LIST COMPREHENSION WITH IF CONDITION

# Find temperatures above 30 degrees

temperatures = [24, 32, 28, 35, 29, 38, 26, 41]

hot_days = [temp for temp in temperatures if temp > 30]

print("Temperatures above 30:", hot_days)


# 3. LIST COMPREHENSION WITH IF-ELSE

# Classify ages as Adult or Minor

ages = [12, 18, 25, 15, 32, 16, 21, 14]

result = [
    "Adult" if age >= 18 else "Minor"
    for age in ages
]

print("Age Classification:", result)


# 4. STRING LIST COMPREHENSION

# Add a welcome message to each name

names = ["Samruddhi", "Riya", "Kavya", "Tanvi"]

result = [
    "Welcome " + name
    for name in names
]

print("Welcome Messages:", result)


# 5. STRING LIST COMPREHENSION

# Find the first letter of each city

cities = ["Kolhapur", "Pune", "Mumbai", "Nashik", "Nagpur"]

result = [
    city[0]
    for city in cities
]

print("First Letters:", result)


# 6. FILTERING STRINGS

# Find cities whose names contain more than 6 characters

cities = [
    "Kolhapur",
    "Pune",
    "Mumbai",
    "Bengaluru",
    "Nagpur",
    "Hyderabad"
]

result = [
    city
    for city in cities
    if len(city) > 6
]

print("Cities with more than 6 characters:", result)


# 7. FILTER + TRANSFORM

# Find numbers divisible by 3 and multiply them by 5

numbers = [7, 9, 12, 14, 18, 21, 25, 30]

result = [
    x * 5
    for x in numbers
    if x % 3 == 0
]

print("Multiples of 3 multiplied by 5:", result)


# 8. LIST COMPREHENSION WITH FUNCTION

# Calculate the area of squares

def square_area(side):
    return side * side

sides = [2, 4, 6, 8, 10]

areas = [
    square_area(side)
    for side in sides
]

print("Areas of Squares:", areas)


# 9. NESTED LIST COMPREHENSION

# Extract all subjects from multiple semester lists

semesters = [
    ["Pharmacology", "Pharmaceutics"],
    ["Biochemistry", "Microbiology"],
    ["Clinical Pharmacy", "Pharmacovigilance"]
]

subjects = [
    subject
    for semester in semesters
    for subject in semester
]

print("All Subjects:", subjects)


# 10. NESTED LOOPS

# Create combinations of sizes and colors

sizes = ["Small", "Medium", "Large"]
colors = ["Black", "White"]

combinations = [
    (size, color)
    for size in sizes
    for color in colors
]

print("Available Combinations:", combinations)


# 11. MULTIPLE IF CONDITIONS

# Find numbers that are:
# Greater than 10
# Even
# Less than 30

numbers = range(1, 40)

result = [
    x
    for x in numbers
    if x > 10
    if x % 2 == 0
    if x < 30
]

print("Numbers matching all conditions:", result)


# 12. MATRIX USING LIST COMPREHENSION

# Create a 3 x 4 matrix containing 1

matrix = [
    [1 for column in range(4)]
    for row in range(3)
]

print("Matrix:", matrix)


# 13. MULTIPLICATION TABLE USING LIST COMPREHENSION

# Create multiplication tables from 5 to 7

tables = [
    [number * multiplier for multiplier in range(1, 11)]
    for number in range(5, 8)
]

print("Multiplication Tables:", tables)


# 14. NORMAL LOOP VS LIST COMPREHENSION

# Normal loop:

numbers = [4, 8, 12, 15, 20, 25]

# result = []

# for number in numbers:
#     if number > 10:
#         result.append(number + 5)


# List comprehension:

result = [
    number + 5
    for number in numbers
    if number > 10
]

print("Numbers after adding 5:", result)


# 15. PASS / FAIL

# Check whether students passed based on attendance

attendance = [92, 76, 58, 81, 65, 45, 89, 72]

result = [
    "Eligible" if percentage >= 75 else "Not Eligible"
    for percentage in attendance
]

print("Attendance Status:", result)


# 16. POSITIVE / NEGATIVE / ZERO

# Classify transaction amounts

transactions = [1200, -450, 0, 850, -200, 1750, 0]

result = [
    "Credit" if amount > 0
    else "Debit" if amount < 0
    else "No Transaction"
    for amount in transactions
]

print("Transaction Status:", result)


# 17. REMOVE EMPTY VALUES

# Remove empty values from a list of phone numbers

phone_numbers = [
    "9876543210",
    "",
    "9123456780",
    "",
    "9988776655",
    "9090909090"
]

result = [
    number
    for number in phone_numbers
    if number != ""
]

print("Valid Phone Numbers:", result)


# 18. FILTER EMPLOYEES BY DEPARTMENT

# Get employees working in the IT department

employees = [
    ("Samruddhi", "Data Analytics"),
    ("Rahul", "IT"),
    ("Kavya", "HR"),
    ("Amit", "IT"),
    ("Sneha", "Finance"),
    ("Riya", "IT")
]

it_employees = [
    name
    for name, department in employees
    if department == "IT"
]

print("IT Employees:", it_employees)


# 19. FILTER PRODUCTS BY STOCK

# Find products that have stock below 10

inventory = [
    ("Keyboard", 15),
    ("Mouse", 7),
    ("Monitor", 4),
    ("USB Cable", 20),
    ("Webcam", 6)
]

low_stock = [
    product
    for product, stock in inventory
    if stock < 10
]

print("Low Stock Products:", low_stock)


# 20. FILTER ITEMS BY CATEGORY

# Get only stationery items

items = [
    ("Pen", "Stationery"),
    ("Notebook", "Stationery"),
    ("Coffee Mug", "Kitchen"),
    ("Pencil", "Stationery"),
    ("Water Bottle", "Kitchen"),
    ("Eraser", "Stationery")
]

stationery = [
    item
    for item, category in items
    if category == "Stationery"
]

print("Stationery Items:", stationery)


# 21. FILTER STUDENTS BY SCORE

# Find students who scored 80 or more

students = [
    ("Samruddhi", 86),
    ("Meera", 72),
    ("Aditya", 91),
    ("Kiran", 68),
    ("Pooja", 84)
]

high_scorers = [
    name
    for name, score in students
    if score >= 80
]

print("High Scoring Students:", high_scorers)


# 22. FILTER EMAIL ADDRESSES

# Find company email addresses

emails = [
    "samruddhi@company.com",
    "rahul@gmail.com",
    "kavya@company.com",
    "amit@yahoo.com",
    "riya@company.com"
]

company_emails = [
    email
    for email in emails
    if "@company.com" in email
]

print("Company Emails:", company_emails)


# 23. PHARMACY EXAMPLE

# Find medicines that require a prescription

medicines = [
    ("Paracetamol", "OTC"),
    ("Amoxicillin", "Prescription"),
    ("Vitamin C", "OTC"),
    ("Metformin", "Prescription"),
    ("Antacid", "OTC")
]

prescription_medicines = [
    medicine
    for medicine, medicine_type in medicines
    if medicine_type == "Prescription"
]

print("Prescription Medicines:", prescription_medicines)


# 24. DATA ANALYTICS EXAMPLE

# Find datasets having more than 1000 records

datasets = [
    ("Sales Dataset", 850),
    ("Customer Dataset", 2500),
    ("Healthcare Dataset", 1750),
    ("Employee Dataset", 620),
    ("Transaction Dataset", 3200)
]

large_datasets = [
    name
    for name, records in datasets
    if records > 1000
]

print("Datasets with more than 1000 records:", large_datasets)


# 25. DATA CLEANING EXAMPLE

# Remove None values from a dataset

data = [25, 40, None, 55, 62, None, 78, 90]

clean_data = [
    value
    for value in data
    if value is not None
]

print("Clean Data:", clean_data)

