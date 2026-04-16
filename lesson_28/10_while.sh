#!/bin/bash

# while — поки умова ПРАВДА
count=1
while [[ $count -le 7 ]]; do
    echo "count = $count"
    (( count++ ))
done

# Читання файлу рядок за рядком
while IFS= read -r line; do
    echo "Рядок: $line"
done < /etc/hosts

# until — поки умова ХИБНА
n=10
until [[ $n -le 0 ]]; do
    echo "$n........"
    (( n-- ))
done
echo "Пуск! 🚀"

# break та continue
for i in {1..10}; do
    [[ $i -eq 5 ]] && continue   # пропустити 5
    [[ $i -eq 3 ]] && break      # зупинитись на 8
    echo $i
done