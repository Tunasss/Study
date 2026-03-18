#!/bin/bash

    echo "Usage: $0 <StudentID>"
    exit 1
fi

TARGET_ID=$1

while IFS=';' read -r sid name grade_raw; do

    if [ "$sid" = "StudentID" ]; then
        continue
    fi

    grade=${grade_raw//$'\r'/}

    if [ "$sid" = "$TARGET_ID" ]; then

        if [ "$grade" -ge 900 ]; then
            letter="A"
        elif [ "$grade" -ge 800 ]; then
            letter="B"
        elif [ "$grade" -ge 700 ]; then
            letter="C"
        elif [ "$grade" -ge 600 ]; then
            letter="D"
        else
            letter="F"
        fi

        echo "Student ID:   $sid"
        echo "Student Name: $name"
        echo "Numeric Grade: $grade"
        echo "Letter Grade:  $letter"
        exit 0
    fi

done < gradebook.csv

echo "Error: Student ID $TARGET_ID not found."
exit 1
