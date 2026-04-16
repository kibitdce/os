#!/bin/bash

# 1. Перебір списку
for color in червоний зелений синій; do
    echo "Колір: $color"
done

# 2. Числовий діапазон
for i in {1..50}; do
    echo "Крок $i"
done

# 3. C-style цикл (як у C/Java)
for (( i=0; i<10; i++ )); do
    echo "i = $i"
done

# 4. Перебір файлів
for file in *.txt; do
    echo "Обробляю: $file"
    wc -l "$file"
done

# 5. Перебір рядків виводу команди
for user in $(cat /etc/passwd | cut -d: -f1 | head -5); do
    echo "Користувач: $user"
done