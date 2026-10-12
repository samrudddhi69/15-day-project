
import os
import mysql.connector


def create_connection():
    try:
        connection = mysql.connector.connect(
            host=os.getenv("DB_HOST", "localhost"),
            user=os.getenv("DB_USER", "root"),
            password=os.getenv("DB_PASSWORD", ""),
            database=os.getenv(
                "DB_NAME",
                "hospital_management_system"
            )
        )

        if connection.is_connected():
            print("MySQL Database Connected Successfully!")

        return connection

    except mysql.connector.Error as error:
        print("Database connection failed:", error)
        return None


if __name__ == "__main__":
    connection = create_connection()

    if connection:
        connection.close()
        print("Database connection closed.")
