#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <string> <path>"
    exit 1
fi

search="$1"
path="$2"

if [ ! -d "$path" ]; then
    echo "Error: '$path' is not a valid directory."
    exit 1
fi

grep -nH -R -F "$search" "$path"/*.txt 2>/dev/null

if [ $? -ne 0 ]; then
    echo "String '$search' not found in any text file in $path."
fi
