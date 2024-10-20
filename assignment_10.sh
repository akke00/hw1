#!/bin/bash

# Сохраняем текущее значение переменной PATH
original_path=$PATH

# Выводим текущее значение PATH
echo "Текущее значение PATH: $PATH"

# Добавляем домашнюю директорию текущего пользователя в PATH
export PATH="$HOME:$PATH"

# Проверяем, что домашняя директория добавлена
echo "Новое значение PATH: $PATH"

# Создаем файл assignment_10_internal_script.sh в домашней директории
internal_script="$HOME/assignment_10_internal_script.sh"
echo 'echo "Content of internal script"' > "$internal_script"

# Даем права на исполнение пользователю-владельцу
chmod u+x "$internal_script"

# Запускаем созданный скрипт
echo "Запуск internal script:"
assignment_10_internal_script.sh

# Восстанавливаем исходное значение PATH
export PATH="$original_path"
echo "PATH восстановлен: $PATH"

# Пытаемся снова запустить скрипт
echo "Повторный запуск internal script:"
if assignment_10_internal_script.sh 2>/dev/null; then
    echo "Да, получилось запустить скрипт."
else
    echo "Нет, не получилось запустить скрипт, потому что домашняя директория больше не в PATH."
fi

