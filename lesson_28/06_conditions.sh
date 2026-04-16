#!/bin/bash
age=67

if [[ $age -lt 18 ]]; then
    echo "Неповнолітній"
elif [[ $age -ge 18 && $age -lt 65 ]]; then
    echo "Дорослий"
else
    echo "Пенсіонер"
fi

# Порівняння чисел
# -eq  рівно        -ne  не рівно
# -lt  менше        -gt  більше
# -le  менше/рівно  -ge  більше/рівно