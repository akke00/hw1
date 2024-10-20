#!/bin/bash


if [ $# -eq 0 ]; then
    N=5  
elif [[ $1 =~ ^[1-9][0-9]*$ ]]; then
    N=$1  
else
    echo "Error:use a positive integer as an argument"
    exit 1
fi

binomial() {
    n=$1
    k=$2
    res=1
    for ((i=0; i<k; i++)); do
        res=$((res * (n - i) / (i + 1)))
    done
    echo $res
}

for ((i=0; i<N; i++)); do
    for ((j=0; j<=i; j++)); do
        printf "%-4s" "$(binomial $i $j)"
    done
    echo
done

