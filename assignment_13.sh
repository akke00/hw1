#!/bin/bash

# Проверка аргументов командной строки
if [ $# -ne 1 ]; then
    echo "Usage: $0 <path_to_words_file>"
    exit 1
fi

words_file=$1

# Проверяем, существует ли файл со словами
if [ ! -f "$words_file" ]; then
    echo "Error: File not found - $words_file"
    exit 1
fi

# Инициализация счета
user_score=0
computer_score=0

# Функция для выбора случайного слова из файла
choose_word() {
    word=$(shuf -n 1 "$words_file" | tr '[:upper:]' '[:lower:]')
    echo $word
}

# Функция для запуска одного раунда игры
play_round() {
    secret_word=$(choose_word)  # Загаданное слово
    word_length=${#secret_word}  # Длина слова
    guessed_word=$(printf '_%.0s' $(seq 1 $word_length))  # Строка с пропусками
    attempts_left=6  # Количество попыток

    used_letters=()  # Массив с использованными буквами

    echo "Загадано слово из $word_length букв. У вас есть $attempts_left попыток."

    while [ "$guessed_word" != "$secret_word" ] && [ $attempts_left -gt 0 ]; do
        echo "Слово: $guessed_word"
        echo "Использованные буквы: ${used_letters[@]}"
        echo "Осталось попыток: $attempts_left"
        
        read -p "Введите букву: " letter
        letter=$(echo "$letter" | tr '[:upper:]' '[:lower:]')  # Приводим к нижнему регистру

        # Проверяем, что введена ровно одна буква
        if [[ ! "$letter" =~ ^[a-zа-я]$ ]]; then
            echo "Пожалуйста, введите одну букву."
            continue
        fi

        # Проверяем, что буква не была использована ранее
        if [[ " ${used_letters[@]} " =~ " $letter " ]]; then
            echo "Эта буква уже была использована."
            continue
        fi

        used_letters+=("$letter")  # Добавляем букву в список использованных

        if [[ "$secret_word" == *"$letter"* ]]; then
            echo "Угадали!"
            # Открываем все вхождения буквы в загаданном слове
            for ((i=0; i<$word_length; i++)); do
                if [ "${secret_word:$i:1}" == "$letter" ]; then
                    guessed_word="${guessed_word:0:$i}$letter${guessed_word:$((i + 1))}"
                fi
            done
        else
            echo "Неправильно."
            attempts_left=$((attempts_left - 1))
        fi
    done

    if [ "$guessed_word" == "$secret_word" ]; then
        echo "Поздравляем! Вы угадали слово: $secret_word"
        user_score=$((user_score + 1))
    else
        echo "Вы проиграли. Загаданное слово: $secret_word"
        computer_score=$((computer_score + 1))
    fi
}

# Основной игровой цикл
echo "Добро пожаловать в игру 'Виселица'!"

while true; do
    play_round  # Запускаем раунд

    echo "Текущий счет: Вы - $user_score | Компьютер - $computer_score"

    read -p "Хотите сыграть еще раз? (y/n): " answer
    if [[ "$answer" != "y" ]]; then
        echo "Спасибо за игру!"
        break
    fi
done

