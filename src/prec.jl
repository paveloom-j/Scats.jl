# This file contains a module
# containing types of numbers
# used in the package, and
# also their according formats

"""
Module containing types of numbers used in the package, and also their according formats.
"""
module prec
export IT, RT, RF

# Определение типа целых чисел
"Type of integer values. Default value: `typeof(1)`."
IT = typeof(1)

# Определение типа вещественных чисел
"Type of real values. Default value: `typeof(1.0)`."
RT = typeof(1.0)

"Format of real values. Default value: `typeof(1.0)`."
RF = "% .6E"

# Определение формата для вывода вещественных чисел
if (RT == Float64)
    RF = "% .15E"
elseif (RT == Float16)
    RF = "% .3E"
end

end