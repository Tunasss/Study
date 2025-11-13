#!/bin/bash

read -p "Enter your age: " age

if ! [[ "$age" =~ ^[0-9]+$ ]]; then
    echo "Error: Age must be a number."
    exit 1
fi

age=$((age))

if [ "$age" -lt 0 ] || [ "$age" -gt 100 ]; then
    echo "Error: Age must be between 0 and 100."
    exit 1
fi

if [ "$age" -lt 12 ]; then
    echo "You are a child."
elif [ "$age" -le 18 ]; then
    echo "You are a teenager."
else
    echo "You are an adult."
fi
