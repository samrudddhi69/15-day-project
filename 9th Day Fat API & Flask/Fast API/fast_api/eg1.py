from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from typing import Optional

app = FastAPI()


# =========================
# PYDANTIC MODELS
# =========================

class Student(BaseModel):
    name: str
    course: str
    marks: int = Field(..., ge=0, le=100)


class StudentResponse(BaseModel):
    name: str
    course: str
    marks: int


class StudentUpdate(BaseModel):
    name: Optional[str] = None
    course: Optional[str] = None
    marks: Optional[int] = Field(None, ge=0, le=100)


# =========================
# STUDENT DATA
# =========================

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
    }
}


# =========================
# 1. HOME API
# =========================

@app.get("/")
def home():
    return {
        "message": "Student Management API is working!"
    }


# =========================
# 2. GET STUDENT
# =========================

@app.get(
    "/students/{student_id}",
    response_model=StudentResponse
)
def get_student(student_id: int):

    if student_id not in students:
        raise HTTPException(
            status_code=404,
            detail="Student not found"
        )

    return students[student_id]


# =========================
# 3. SEARCH STUDENTS
# =========================

@app.get("/search")
def search_students(
    course: Optional[str] = None,
    min_marks: Optional[int] = None
):

    results = []

    for student in students.values():

        if course is not None:
            if student["course"].lower() != course.lower():
                continue

        if min_marks is not None:
            if student["marks"] < min_marks:
                continue

        results.append(student)

    return results


# =========================
# 4. ADD STUDENT
# =========================

@app.post("/students")
def add_student(student: Student):

    new_id = max(students.keys()) + 1

    students[new_id] = student.model_dump()

    return {
        "message": "Student added successfully",
        "student_id": new_id,
        "student": students[new_id]
    }


# =========================
# 5. UPDATE STUDENT - PUT
# =========================

@app.put("/students/{student_id}")
def update_student(
    student_id: int,
    student: Student
):

    if student_id not in students:
        raise HTTPException(
            status_code=404,
            detail="Student not found"
        )

    students[student_id] = student.model_dump()

    return {
        "message": "Student updated successfully",
        "student_id": student_id,
        "student": students[student_id]
    }


# =========================
# 6. DELETE STUDENT
# =========================

@app.delete("/students/{student_id}")
def delete_student(student_id: int):

    if student_id not in students:
        raise HTTPException(
            status_code=404,
            detail="Student not found"
        )

    deleted_student = students.pop(student_id)

    return {
        "message": "Student deleted successfully",
        "student_id": student_id,
        "student": deleted_student
    }


# =========================
# 7. PATCH STUDENT
# =========================

@app.patch("/students/{student_id}")
def patch_student(
    student_id: int,
    student: StudentUpdate
):

    if student_id not in students:
        raise HTTPException(
            status_code=404,
            detail="Student not found"
        )

    update_data = student.model_dump(
        exclude_unset=True
    )

    students[student_id].update(update_data)

    return {
        "message": "Student partially updated",
        "student_id": student_id,
        "student": students[student_id]
    }


# =========================
# 8. PAGINATION
# =========================

@app.get("/students")
def get_students(
    page: int = 1,
    limit: int = 2
):

    start = (page - 1) * limit
    end = start + limit

    student_list = list(students.values())

    return {
        "page": page,
        "limit": limit,
        "total_students": len(student_list),
        "students": student_list[start:end]
    }


# =========================
# 9. STUDENT STATISTICS
# =========================

@app.get("/stats")
def student_statistics():

    student_list = list(students.values())

    marks = []

    for student in student_list:
        marks.append(student["marks"])

    total_students = len(student_list)

    average_marks = sum(marks) / total_students

    highest_marks = max(marks)

    lowest_marks = min(marks)

    course_count = {}

    for student in student_list:

        course = student["course"]

        if course not in course_count:
            course_count[course] = 0

        course_count[course] += 1

    return {
        "total_students": total_students,
        "average_marks": average_marks,
        "highest_marks": highest_marks,
        "lowest_marks": lowest_marks,
        "students_by_course": course_count
    }