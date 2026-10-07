from flask import Flask, request, jsonify
import json

app = Flask(__name__)

FILE_NAME = "appointments.json"


# Load appointments from JSON file
def load_appointments():
    with open(FILE_NAME, "r") as file:
        return json.load(file)


# Save appointments to JSON file
def save_appointments(appointments):
    with open(FILE_NAME, "w") as file:
        json.dump(appointments, file, indent=4)


# Home API
@app.route("/")
def home():
    return jsonify({
        "message": "Hospital Appointment REST API is running"
    }), 200


# GET - Get all appointments
@app.route("/appointments", methods=["GET"])
def get_appointments():

    appointments = load_appointments()

    return jsonify(appointments), 200


# GET - Get appointment by ID
@app.route("/appointments/<int:appointment_id>", methods=["GET"])
def get_appointment(appointment_id):

    appointments = load_appointments()

    for appointment in appointments:

        if appointment["appointment_id"] == appointment_id:
            return jsonify(appointment), 200

    return jsonify({
        "error": "Appointment not found"
    }), 404


# GET - Search by department
@app.route("/appointments/search", methods=["GET"])
def search_appointments():

    department = request.args.get("department")

    if not department:
        return jsonify({
            "error": "Department parameter is required"
        }), 400

    appointments = load_appointments()

    result = []

    for appointment in appointments:

        if appointment["department"].lower() == department.lower():
            result.append(appointment)

    return jsonify(result), 200


# POST - Create new appointment
@app.route("/appointments", methods=["POST"])
def create_appointment():

    data = request.get_json()

    if not data:
        return jsonify({
            "error": "JSON data is required"
        }), 400

    required_fields = [
        "patient_name",
        "doctor_name",
        "department",
        "appointment_date",
        "status"
    ]

    for field in required_fields:

        if field not in data:
            return jsonify({
                "error": f"{field} is required"
            }), 400

    appointments = load_appointments()

    new_id = max(
        [appointment["appointment_id"] for appointment in appointments],
        default=100
    ) + 1

    new_appointment = {
        "appointment_id": new_id,
        "patient_name": data["patient_name"],
        "doctor_name": data["doctor_name"],
        "department": data["department"],
        "appointment_date": data["appointment_date"],
        "status": data["status"]
    }

    appointments.append(new_appointment)

    save_appointments(appointments)

    return jsonify({
        "message": "Appointment created successfully",
        "appointment": new_appointment
    }), 201


# PUT - Complete update
@app.route("/appointments/<int:appointment_id>", methods=["PUT"])
def update_appointment(appointment_id):

    appointments = load_appointments()

    data = request.get_json()

    if not data:
        return jsonify({
            "error": "JSON data is required"
        }), 400

    for appointment in appointments:

        if appointment["appointment_id"] == appointment_id:

            appointment["patient_name"] = data.get("patient_name")
            appointment["doctor_name"] = data.get("doctor_name")
            appointment["department"] = data.get("department")
            appointment["appointment_date"] = data.get("appointment_date")
            appointment["status"] = data.get("status")

            save_appointments(appointments)

            return jsonify({
                "message": "Appointment completely updated",
                "appointment": appointment
            }), 200

    return jsonify({
        "error": "Appointment not found"
    }), 404


# PATCH - Partial update
@app.route("/appointments/<int:appointment_id>", methods=["PATCH"])
def patch_appointment(appointment_id):

    appointments = load_appointments()

    data = request.get_json()

    if not data:
        return jsonify({
            "error": "JSON data is required"
        }), 400

    for appointment in appointments:

        if appointment["appointment_id"] == appointment_id:

            if "patient_name" in data:
                appointment["patient_name"] = data["patient_name"]

            if "doctor_name" in data:
                appointment["doctor_name"] = data["doctor_name"]

            if "department" in data:
                appointment["department"] = data["department"]

            if "appointment_date" in data:
                appointment["appointment_date"] = data["appointment_date"]

            if "status" in data:
                appointment["status"] = data["status"]

            save_appointments(appointments)

            return jsonify({
                "message": "Appointment partially updated",
                "appointment": appointment
            }), 200

    return jsonify({
        "error": "Appointment not found"
    }), 404


# DELETE - Delete appointment
@app.route("/appointments/<int:appointment_id>", methods=["DELETE"])
def delete_appointment(appointment_id):

    appointments = load_appointments()

    for appointment in appointments:

        if appointment["appointment_id"] == appointment_id:

            appointments.remove(appointment)

            save_appointments(appointments)

            return jsonify({
                "message": "Appointment deleted successfully"
            }), 200

    return jsonify({
        "error": "Appointment not found"
    }), 404


# 404 Error
@app.errorhandler(404)
def not_found(error):

    return jsonify({
        "error": "Endpoint or appointment not found"
    }), 404


# 405 Error
@app.errorhandler(405)
def method_not_allowed(error):

    return jsonify({
        "error": "HTTP method not allowed"
    }), 405


# 500 Error
@app.errorhandler(500)
def internal_error(error):

    return jsonify({
        "error": "Internal server error"
    }), 500


# Run Flask application
if __name__ == "__main__":
    app.run(debug=True)