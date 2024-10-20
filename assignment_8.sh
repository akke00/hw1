#!/bin/bash

# Генерируем случайное число от 0 до 100
target=$((RANDOM % 101))
max_attempts=10  
attempts=0      

echo «Саламалейкум друг! Добро пожаловать в игру 'Угадай число'!"
echo "Я загадал число от 0 до 100. Попробуйте его угадать за $max_attempts попыток."

# Основной цикл игры
while [ $attempts -lt $max_attempts ]; do
    attempts=$((attempts + 1))
    

    read -p "Попытка $attempts: Введите число: " guess
    
    if ! [[ $guess =~ ^[0-9]+$ ]]; then
        echo «Плиз, введите целое число."
        attempts=$((attempts - 1)) 
        continue
    fi

    if [ $guess -eq $target ]; then
        echo «Красавчик! Вы угадали число $target за $attempts попыток."
        exit 0
    elif [ $guess -lt $target ]; then
        echo "Загаданное число больше."
    else
        echo "Загаданное число меньше."
    fi
done


echo "К сожалению, вы не угадали число за $max_attempts попыток. Загаданное число было: $target"

