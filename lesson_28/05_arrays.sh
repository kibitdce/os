#!/bin/bash
echo $1
echo $2

# Оголошення масиву
fruits=("яблуко" "банан" "вишня")

echo "Перший: ${fruits[0]}"      # → яблуко
echo "Всі: ${fruits[@]}"         # → яблуко банан вишня
echo "Кількість: ${#fruits[@]}"  # → 3

# Додати елемент
fruits+=("груша")

# Перебрати масив
for fruit in "${fruits[@]}"; do
    echo "🍎 $fruit"
done

# Асоціативний масив (словник)
declare -A user
user["name"]="Олег"
user["age"]="25"
echo "${user[name]}, ${user[age]} р."
echo $@
echo PID: $$
echo $PATH