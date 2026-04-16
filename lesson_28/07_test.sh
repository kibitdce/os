#!/bin/bash

# === РЯДКИ ===
str1="bash"
str2="python"

if [[ "$str1" == "$str2" ]]; then
    echo "однакові"
fi
if [[ -z "$str1" ]]; then   # -z = порожній рядок
    echo "порожній"
fi
if [[ "$str1" == *"as"* ]]; then  # wildcard match
    echo "містить 'as'"
fi

# === ФАЙЛИ ===
if [[ -f "/etc/hosts" ]]; then
    echo "файл існує"
fi
if [[ -d "/home" ]]; then
    echo "це директорія"
fi
if [[ -r "file.txt" ]]; then  # -r читабельний, -w записуваний, -x виконуваний
    echo "можна читати"
fi