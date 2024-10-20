#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: ./assignment_2.sh <file_path>"
    exit 1
fi

file_path="$1"

word_count=$(wc -w < "$file_path")

echo "Words count: $word_count"

