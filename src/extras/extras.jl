# Этот файл содержит описания некоторых
# вспомогательных функций для Scats.jl

module extras
export println

using Formatting # Форматированный вывод
import Base.println # Стандартная функция println

using ..prec # Точность вещественных чисел

include("extras_fmt.jl") # Расширения println для
                         # вывода вещественных чисел
end