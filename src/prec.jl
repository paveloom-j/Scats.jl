# Этот файл содержит определения
# типов численных данных,
# используемые в модуле Scats.jl,
# а также соответствующие им форматы

"oof"
module prec
export IT, RT, RF

# Определение типа целых чисел
"oof"
IT = typeof(1)

# Определение типа вещественных чисел
"oof"
RT = typeof(1.0)

"oof"
RF = "% .6E"

# Определение формата для вывода вещественных чисел
if (RT == Float64)
    RF = "% .15E"
elseif (RT == Float16)
    RF = "% .3E"
end

end