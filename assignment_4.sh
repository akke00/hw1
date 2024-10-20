#!/bin/bash


if [ $# -lt 1 ]; then
    echo "Usage: ./assignment_4.sh <file1> <file2> ... <fileN>"
    exit 1
fi


for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "ERROR: File not found: $file"
        exit 1
    fi
done


archive_name="archive_$(date +%Y%m%d%H%M%S).tar.gz"
archive_path="$HOME/$archive_name"


tar -czf "$archive_path" "$@"


echo "Archive created: $archive_path"

