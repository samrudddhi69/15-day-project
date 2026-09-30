# DAY 3: ASYNCHRONOUS PROGRAMMING


# THEORY:
# Asynchronous programming allows a program to work on other tasks
# while waiting for an operation such as an API, database,
# network or file operation.

# Synchronous:
# Task 1 -> wait -> finish -> Task 2

# Asynchronous:
# Task 1 -> waiting
# Task 2 -> can run while Task 1 is waiting

# asyncio is Python's built-in library for asynchronous programming.

import asyncio


# 1. Basic Async Function

# THEORY:
# An async function is created using async def.
# asyncio.run() is used to execute an async function.

async def greet():
    print("Hello from async function")

asyncio.run(greet())


# 2. Using await

# THEORY:
# await is used inside an async function.
# It waits for an asynchronous operation to complete.
# While waiting, the event loop can handle other tasks.

async def process_data():

    print("Processing started")

    await asyncio.sleep(1.5)

    print("Processing completed")

asyncio.run(process_data())


# 3. asyncio.sleep()

# THEORY:
# asyncio.sleep() pauses the current async task without
# blocking the entire event loop.

# It can simulate waiting for:
# API response
# Database response
# Network operation
# File operation

async def wait_example():

    print("Waiting started")

    await asyncio.sleep(2.5)

    print("Waiting completed")

asyncio.run(wait_example())


# 4. Async Function with Parameters

# THEORY:
# Async functions can accept parameters just like normal functions.

async def get_user(user_id):

    await asyncio.sleep(1.5)

    return {
        "id": user_id,
        "name": "Neha"
    }


async def main_user():

    user = await get_user(201)

    print("User:", user)

asyncio.run(main_user())


# 5. Async Function Returning Data

# THEORY:
# Async functions can return values using return.
# The returned value is received using await.

async def get_sales():

    await asyncio.sleep(1.5)

    return [1350, 1650, 1950, 2250]


async def main_sales():

    sales = await get_sales()

    total = sum(sales)

    print("Sales:", sales)
    print("Total Sales:", total)

asyncio.run(main_sales())


# 6. Sequential Async Execution

# THEORY:
# If we use await one after another, the operations execute
# sequentially.

# Task 1 finishes first.
# Then Task 2 starts.

# Async does not automatically mean concurrent.

async def task1():

    print("Task 1 started")

    await asyncio.sleep(2.5)

    print("Task 1 completed")


async def task2():

    print("Task 2 started")

    await asyncio.sleep(2.5)

    print("Task 2 completed")


async def main_sequential():

    await task1()
    await task2()

asyncio.run(main_sequential())


# 7. asyncio.gather()

# THEORY:
# asyncio.gather() is used to run multiple independent
# asynchronous operations concurrently.

# Example:
# Fetch users
# Fetch products
# Fetch orders

async def task3():

    print("Task 3 started")

    await asyncio.sleep(2.5)

    print("Task 3 completed")

    return "Task 3 result"


async def task4():

    print("Task 4 started")

    await asyncio.sleep(2.5)

    print("Task 4 completed")

    return "Task 4 result"


async def main_gather():

    result1, result2 = await asyncio.gather(
        task3(),
        task4()
    )

    print(result1)
    print(result2)

asyncio.run(main_gather())


# 8. Multiple Async Operations

# THEORY:
# Independent API or database operations can be executed
# concurrently using asyncio.gather().

async def fetch_users():

    await asyncio.sleep(2.5)

    return ["Neha", "Rohan", "Sneha"]


async def fetch_products():

    await asyncio.sleep(2.5)

    return ["Tablet", "Monitor", "Mouse"]


async def fetch_orders():

    await asyncio.sleep(2.5)

    return [201, 202, 203]


async def main_data():

    users, products, orders = await asyncio.gather(
        fetch_users(),
        fetch_products(),
        fetch_orders()
    )

    print("Users:", users)
    print("Products:", products)
    print("Orders:", orders)

asyncio.run(main_data())


# 9. asyncio.create_task()

# THEORY:
# asyncio.create_task() schedules an async function as a Task.
# It is useful when we want to start an async operation and
# keep a reference to that task.

async def send_email():

    await asyncio.sleep(2.5)

    return "Email sent successfully"


async def generate_report():

    await asyncio.sleep(1.5)

    return "Report generated successfully"


async def main_tasks():

    email_task = asyncio.create_task(send_email())

    report_task = asyncio.create_task(generate_report())

    email_result = await email_task
    report_result = await report_task

    print(email_result)
    print(report_result)

asyncio.run(main_tasks())


# 10. Event Loop

# THEORY:
# The event loop manages and schedules asynchronous tasks.

# When one task is waiting for an I/O operation,
# the event loop can allow another task to run.

# asyncio.run() creates and manages the event loop for
# a normal asyncio program.

async def api1():

    await asyncio.sleep(2.5)

    return "API 1 data"


async def api2():

    await asyncio.sleep(3.5)

    return "API 2 data"


async def main_event_loop():

    results = await asyncio.gather(
        api1(),
        api2()
    )

    print("API Results:", results)

asyncio.run(main_event_loop())


# 11. Async Error Handling

# THEORY:
# Normal try-except can be used with async functions.
# Errors raised inside async functions can be handled
# using try-except.

async def process_transaction():

    await asyncio.sleep(1.5)

    raise ValueError("Transaction failed")


async def main_error():

    try:

        await process_transaction()

    except ValueError as error:

        print("Error:", error)

asyncio.run(main_error())


# 12. Async try-except-finally

# THEORY:
# try-except-finally works with async functions just like
# normal Python functions.

# finally executes whether an error occurs or not.

async def connect_database():

    print("Connecting to database...")

    await asyncio.sleep(1.5)

    raise ConnectionError("Database connection failed")


async def main_database():

    try:

        await connect_database()

    except ConnectionError as error:

        print("Error:", error)

    finally:

        print("Connection process completed")

asyncio.run(main_database())


# 13. Error Handling with gather()

# THEORY:
# Multiple async operations can be executed using gather().
# Exceptions can be handled using try-except.

async def get_valid_data():

    await asyncio.sleep(1.5)

    return "Data received"


async def get_invalid_data():

    await asyncio.sleep(1.5)

    raise ValueError("Invalid data")


async def main_gather_error():

    try:

        result1, result2 = await asyncio.gather(
            get_valid_data(),
            get_invalid_data()
        )

        print(result1)
        print(result2)

    except ValueError as error:

        print("Error:", error)

asyncio.run(main_gather_error())


# 14. Timeout

# THEORY:
# Sometimes an API, database or network operation takes
# too long.

# asyncio.wait_for() allows us to set a maximum waiting time.

# If the operation exceeds the timeout,
# asyncio.TimeoutError is raised.

async def long_task():

    print("Task started")

    await asyncio.sleep(6)

    print("Task completed")


async def main_timeout():

    try:

        await asyncio.wait_for(
            long_task(),
            timeout=3
        )

    except asyncio.TimeoutError:

        print("Task took too long")

asyncio.run(main_timeout())


# 15. Async Loop

# THEORY:
# Normal loops can be used inside async functions.
# await can be used inside the loop to allow the event loop
# to handle other asynchronous tasks.

async def display_numbers():

    for number in range(2, 7):

        print(number)

        await asyncio.sleep(0.6)

asyncio.run(display_numbers())


# 16. Concurrent Data Processing

# THEORY:
# Multiple items can be processed concurrently by creating
# tasks and then using asyncio.gather().

async def process_item(item):

    await asyncio.sleep(1.5)

    return f"{item} processed"


async def main_processing():

    items = [
        "Revenue",
        "Invoices",
        "Clients",
        "Services"
    ]

    tasks = [
        asyncio.create_task(process_item(item))
        for item in items
    ]

    results = await asyncio.gather(*tasks)

    for result in results:

        print(result)

asyncio.run(main_processing())

# REAL WORLD USE CASES

# 1. Using Await - File Download

async def download_report():
    print("Downloading monthly report...")
    await asyncio.sleep(2)
    print("Report downloaded successfully")


async def main_download():
    await download_report()


asyncio.run(main_download())


# 2. Multiple Tasks - Food Delivery App

async def check_restaurant():
    print("Checking restaurant availability...")
    await asyncio.sleep(2)
    print("Restaurant available")


async def check_delivery_partner():
    print("Finding delivery partner...")
    await asyncio.sleep(1)
    print("Delivery partner assigned")


async def main_delivery():
    await asyncio.gather(
        check_restaurant(),
        check_delivery_partner()
    )


asyncio.run(main_delivery())


# 3. Async Function Returning Data - Sales System

async def get_daily_sales():
    await asyncio.sleep(1)

    return [2500, 3200, 1800, 4100]


async def main_sales():
    sales = await get_daily_sales()

    total_sales = sum(sales)

    print("Daily Sales:", sales)
    print("Total Sales:", total_sales)


asyncio.run(main_sales())


# 4. Multiple Data Operations - Hospital System

async def get_patient_details():
    await asyncio.sleep(2)
    return "Patient details loaded"


async def get_appointment_details():
    await asyncio.sleep(1)
    return "Appointment details loaded"


async def main_hospital():
    patient, appointment = await asyncio.gather(
        get_patient_details(),
        get_appointment_details()
    )

    print(patient)
    print(appointment)


asyncio.run(main_hospital())