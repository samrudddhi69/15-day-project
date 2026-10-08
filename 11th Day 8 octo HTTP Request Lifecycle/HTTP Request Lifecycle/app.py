from flask import Flask, request, jsonify

app = Flask(__name__)

students = [
    {
        "id": 1,
        "name": "Samruddhi",
        "course": "B.Pharm",
        "marks": 95
    },
    {
        "id": 2,
        "name": "Priya",
        "course": "B.Sc",
        "marks": 78
    },
    {
        "id": 3,
        "name": "Rahul",
        "course": "BCA",
        "marks": 90
    },
    {
        "id": 5,
        "name": "Neha",
        "course": "B.Pharm",
        "marks": 92
    }
]


# Home API
@app.route("/")
def home():
    return {
        "message": "HTTP Request Lifecycle API is running"
    }


# GET - Get all students
@app.route("/students", methods=["GET"])
def get_students():
    return jsonify(students), 200


# GET - Get student by ID
@app.route("/students/<int:student_id>", methods=["GET"])
def get_student(student_id):

    for student in students:
        if student["id"] == student_id:
            return jsonify(student), 200

    return jsonify({
        "error": "Student not found"
    }), 404


# POST - Add a new student
@app.route("/students", methods=["POST"])
def add_student():

    data = request.get_json()

    if not data:
        return jsonify({
            "error": "JSON data is required"
        }), 400

    new_student = {
        "id": max([student["id"] for student in students]) + 1,
        "name": data.get("name"),
        "course": data.get("course"),
        "marks": data.get("marks")
    }

    students.append(new_student)

    return jsonify(new_student), 201


# PATCH - Update student partially
@app.route("/students/<int:student_id>", methods=["PATCH"])
def update_student(student_id):

    data = request.get_json()

    if not data:
        return jsonify({
            "error": "JSON data is required"
        }), 400

    for student in students:

        if student["id"] == student_id:

            if "name" in data:
                student["name"] = data["name"]

            if "course" in data:
                student["course"] = data["course"]

            if "marks" in data:
                student["marks"] = data["marks"]

            return jsonify(student), 200

    return jsonify({
        "error": "Student not found"
    }), 404


# DELETE - Delete student
@app.route("/students/<int:student_id>", methods=["DELETE"])
def delete_student(student_id):

    for student in students:

        if student["id"] == student_id:

            students.remove(student)

            return jsonify({
                "message": "Student deleted successfully"
            }), 200

    return jsonify({
        "error": "Student not found"
    }), 404


# GET - Search students using query parameter
# Example: /search?course=B.Pharm
@app.route("/search", methods=["GET"])
def search_students():

    course = request.args.get("course")

    if not course:
        return jsonify({
            "error": "Course query parameter is required"
        }), 400

    result = []

    for student in students:

        if student["course"] == course:
            result.append(student)

    return jsonify(result), 200


# Run Flask server
if __name__ == "__main__":
    app.run(debug=True)