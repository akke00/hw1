#!/bin/bash

# Проверяем, что введен путь до файла или директории
if [ $# -ne 1 ]; then
    echo "Error: Укажите путь для создания бекапа»
    exit 1
fi

# Переменные
backup_target=$1  # Цель бэкапа (файл или директория)
backup_dir="/var/backups"  # Директория для хранения бэкапов
max_versions=5  # Максимальное количество версий

# Проверяем, существует ли цель для бэкапа
if [ ! -e "$backup_target" ]; then
    echo "Error: Нечего бекапировать $backup_target"
    exit 1
fi

# Создаем директорию для бэкапов, если ее еще нет
mkdir -p "$backup_dir"

# Извлекаем имя файла или директории для создания уникального архива
base_name=$(basename "$backup_target")
timestamp=$(date +%Y%m%d%H%M%S)  # Добавляем метку времени для уникальности
archive_name="${base_name}_${timestamp}.tar.gz"  # Имя архива
archive_path="$backup_dir/$archive_name"

# Создаем архив с указанным содержимым
tar -czf "$archive_path" "$backup_target" 2>/dev/null

# Проверяем, успешно ли создан архив
if [ $? -ne 0 ]; then
    echo "Error: ошибка при создании бекапа $backup_target"
    exit 1
fi

echo "Backup created: $archive_path"

# Управление количеством версий
existing_backups=($(ls -t "$backup_dir/${base_name}_*.tar.gz" 2>/dev/null))  # Список архивов, отсортированных по времени

if [ ${#existing_backups[@]} -gt $max_versions ]; then
    for ((i=$max_versions; i<${#existing_backups[@]}; i++)); do
        rm -f "${existing_backups[$i]}"  # Удаляем старые бэкапы
        echo "Deleted old backup: ${existing_backups[$i]}"
    done
fi

echo "Бекап создан успешно"

