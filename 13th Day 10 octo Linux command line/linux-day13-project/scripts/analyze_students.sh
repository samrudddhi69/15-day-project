
#!/bin/bash

FILE="data/students.txt"

echo "===== STUDENT DATA ANALYSIS ====="

if [ ! -f "$FILE" ]; then
    echo "Error: Student file not found!"
    exit 1
fi

echo "Total Students:"
wc -l < "$FILE"

echo ""
echo "Student Names and Marks:"
awk -F ',' '{print $2, $4}' "$FILE"

echo ""
echo "Students Scoring 80 or Above:"
awk -F ',' '$4 >= 80 {print $2, $4}' "$FILE"

echo ""
echo "BPharm Student Count:"
grep -c "BPharm" "$FILE"

echo ""
echo "Analysis Completed Successfully!"

