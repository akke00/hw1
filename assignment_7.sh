#!/bin/bash


if [ $# -ne 1 ]; then
    echo "Error: something went wrong"
    exit 1
fi

path=$1


if [ -f "$path" ]; then
    echo "File exists"
elif [ -d "$path" ]; then
    echo "It is directory"
else
    echo "File does not exist"
fi

