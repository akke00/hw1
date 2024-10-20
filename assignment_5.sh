#!/bin/bash


if [ $# -ne 1 ]; then
    echo "Usage: ./assignment_5.sh <N>"
    exit 1
fi


if ! [[ $1 =~ ^[1-9][0-9]*$ ]]; then
    echo "ERROR:  enter a positive integer"
    exit 1
fi

N=$1


for ((i=0; i<N; i++)); do
    for ((j=0; j<N; j++)); do
        if [ $i -eq $j ]; then
            printf "1    "
        else
            printf "0    "
        fi
    done
    echo
done

