# Этот файл содержит описания некоторых
# вспомогательных функций для Scats.jl

module extras
export println, _precompile

using Formatting # Форматированный вывод
import Base.println # Стандартная функция println

using ..prec # Точность вещественных чисел

include("extras_fmt.jl") # Расширения println для
                         # вывода вещественных чисел
include("extras_precompile.jl") # Метод для прекомпиляции модуля

end