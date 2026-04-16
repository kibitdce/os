#!/bin/bash
str="Hello, World!"

echo "Довжина: ${#str}"          # → 13
echo "Великі: ${str^^}"          # → HELLO, WORLD!
echo "Малі: ${str,,}"            # → hello, world!
echo "Підрядок: ${str:0:5}"      # → Hello
echo "Заміна: ${str/World/Bash}" # → Hello, Bash!
echo "Видалити префікс: ${str#Hello, }" # → World!

# Конкатенація рядків
first="Добрий"
second="день"
third=$(date +%Y-%m-%d)
full="$first $second date: $third"
echo $full  # → Добрий день