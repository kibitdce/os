#!/bin/bash

# Присвоєння — БЕЗ пробілів навколо =
name="Олег"
age=25
pi=3.14

# Використання змінної — знак $
echo "Привіт, $name!"
echo "Вік: ${age} років"  # {} — для чіткості меж

# Результат команди у змінну
today=$(date +%Y-%m-%d)
files_count=$(ls -1 | wc -l)
echo "Сьогодні: $today, файлів: $files_count"

# Константа (readonly)
readonly MAX_SIZE=100

# Видалити змінну
unset age
echo "Вік після unset: ${age}"  # порожньо, бо змінна видалена