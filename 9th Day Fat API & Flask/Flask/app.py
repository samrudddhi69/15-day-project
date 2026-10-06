from flask import Flask, request

app = Flask(__name__)

students = {
    1: {
        "name": "Samruddhi",
        "course": "B.Pharm",
        "marks": 85
    },
    2: {
        "name": "Priya",
        "course": "B.Sc",
        "marks": 78
    },
    3: {
        "name": "Rahul",
        "course": "BCA",
        "marks": 90
    },
    4: {
        "name": "Sneha",
        "course": "B.Pharm",
        "marks": 92
    },
    5: {
        "name": "Amit",
        "course": "BCA",
        "marks": 70
    }
}


# 1. HOME
@app.route("/")
def home():

    return "Student Management Flask API is working!"


# 2. GET ALL STUDENTS
@app.route("/students", methods=["GET"])
def get_students():

    return {
        "count": len(students),
        "students": list(students.values())
    }


# 3. GET SINGLE STUDENT
@app.route("/students/<int:student_id>", methods=["GET"])
def get_student(student_id):

    if student_id not in students:

        return {
            "error": "Student not found"
        }, 404

    return students[student_id]


# 4. ADD STUDENT - POST
@app.route("/students", methods=["POST"])
def add_student():

    data = request.get_json()

    if not data:

        return {
            "error": "JSON data is required"
        }, 400

    name = data.get("name")
    course = data.get("course")
    marks = data.get("marks")

    if not name or not str(name).strip():

        return {
            "error": "Name is required"
        }, 400

    if not course or not str(course).strip():

        return {
            "error": "Course is required"
        }, 400

    if marks is None:

        return {
            "error": "Marks are required"
        }, 400

    if not isinstance(marks, (int, float)):

        return {
            "error": "Marks must be a number"
        }, 400

    if marks < 0 or marks > 100:

        return {
            "error": "Marks must be between 0 and 100"
        }, 400

    new_id = max(students.keys()) + 1

    students[new_id] = {
        "name": name,
        "course": course,
        "marks": marks
    }

    return {
        "message": "Student added successfully",
        "student_id": new_id,
        "student": students[new_id]
    }, 201


# 5. UPDATE STUDENT - PUT
@app.route("/students/<int:student_id>", methods=["PUT"])
def update_student(student_id):

    if student_id not in students:

        return {
            "error": "Student not found"
        }, 404

    data = request.get_json()

    if not data:

        return {
            "error": "JSON data is required"
        }, 400

    name = data.get("name")
    course = data.get("course")
    marks = data.get("marks")

    if not name or not str(name).strip():

        return {
            "error": "Name is required"
        }, 400

    if not course or not str(course).strip():

        return {
            "error": "Course is required"
        }, 400

    if marks is None:

        return {
            "error": "Marks are required"
        }, 400

    if not isinstance(marks, (int, float)):

        return {
            "error": "Marks must be a number"
        }, 400

    if marks < 0 or marks > 100:

        return {
            "error": "Marks must be between 0 and 100"
        }, 400

    students[student_id] = {
        "name": name,
        "course": course,
        "marks": marks
    }

    return {
        "message": "Student updated successfully",
        "student_id": student_id,
        "student": students[student_id]
    }, 200


# 6. DELETE STUDENT
@app.route("/students/<int:student_id>", methods=["DELETE"])
def delete_student(student_id):

    if student_id not in students:

        return {
            "error": "Student not found"
        }, 404

    deleted_student = students.pop(student_id)

    return {
        "message": "Student deleted successfully",
        "student": deleted_student
    }, 200


# 7. FILTER STUDENTS
@app.route("/students/filter", methods=["GET"])
def filter_students():

    course = request.args.get("course")
    min_marks = request.args.get("min_marks")
    max_marks = request.args.get("max_marks")

    filtered_students = list(students.values())

    if course:

        filtered_students = [
            student
            for student in filtered_students
            if student["course"].lower() == course.lower()
        ]

    if min_marks:

        try:
            min_marks = float(min_marks)

            filtered_students = [
                student
                for student in filtered_students
                if student["marks"] >= min_marks
            ]

        except ValueError:

            return {
                "error": "min_marks must be a number"
            }, 400

    if max_marks:

        try:
            max_marks = float(max_marks)

            filtered_students = [
                student
                for student in filtered_students
                if student["marks"] <= max_marks
            ]

        except ValueError:

            return {
                "error": "max_marks must be a number"
            }, 400

    return {
        "count": len(filtered_students),
        "students": filtered_students
    }


# 8. PAGINATION
@app.route("/students/pagination", methods=["GET"])
def paginate_students():

    page = request.args.get("page", 1, type=int)
    limit = request.args.get("limit", 2, type=int)

    if page < 1:

        return {
            "error": "Page must be greater than 0"
        }, 400

    if limit < 1:

        return {
            "error": "Limit must be greater than 0"
        }, 400

    student_list = list(students.values())

    total_students = len(student_list)

    total_pages = (total_students + limit - 1) // limit

    start = (page - 1) * limit
    end = start + limit

    paginated_students = student_list[start:end]

    if page > total_pages and total_students > 0:

        return {
            "error": "Page does not exist",
            "total_pages": total_pages
        }, 404

    return {
        "page": page,
        "limit": limit,
        "total_students": total_students,
        "total_pages": total_pages,
        "students": paginated_students
    }


# 9. STUDENT STATISTICS
@app.route("/students/statistics", methods=["GET"])
def student_statistics():

    student_list = list(students.values())

    if not student_list:

        return {
            "message": "No students available"
        }

    marks = [
        student["marks"]
        for student in student_list
    ]

    total_students = len(student_list)

    average_marks = sum(marks) / total_students

    highest_marks = max(marks)

    lowest_marks = min(marks)

    passed_students = [
        student
        for student in student_list
        if student["marks"] >= 40
    ]

    failed_students = [
        student
        for student in student_list
        if student["marks"] < 40
    ]

    course_count = {}

    for student in student_list:

        course = student["course"]

        if course in course_count:

            course_count[course] += 1

        else:

            course_count[course] = 1

    return {
        "total_students": total_students,
        "average_marks": round(average_marks, 2),
        "highest_marks": highest_marks,
        "lowest_marks": lowest_marks,
        "passed_students": len(passed_students),
        "failed_students": len(failed_students),
        "course_wise_count": course_count
    }


# 10. 404 ERROR HANDLER
@app.errorhandler(404)
def page_not_found(error):

    return {
        "error": "The requested resource was not found",
        "status": 404
    }, 404


# 11. 405 ERROR HANDLER
@app.errorhandler(405)
def method_not_allowed(error):

    return {
        "error": "HTTP method is not allowed",
        "status": 405
    }, 405


# 12. 500 ERROR HANDLER
@app.errorhandler(500)
def internal_server_error(error):

    return {
        "error": "Internal server error",
        "status": 500
    }, 500


# START FLASK SERVER
if __name__ == "__main__":

    app.run(debug=True)