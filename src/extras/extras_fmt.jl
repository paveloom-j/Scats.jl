# Этот файл содержит определения функций
# для вывода вещественных чисел

# Функция для вывода вещественного числа типа RT
function println(io::IO, value::RT)
    println(io, sprintf1(RF, value))
end

# Функция для вывода массива вещественных чисел типа RT
function println(io::IO, array::Array{RT, 1})
    println(io, join([sprintf1(RF, s) for s in array], " "^3))
end