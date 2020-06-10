# This file contains a module
# containing types of numbers
# used in the package, and
# also their according formats

"""
Module containing types of numbers used in the package, and also their according formats.
"""
module prec
export IT, RT, RF

"Type of integer values. Default value: `typeof(1)`."
IT = typeof(1)

"Type of real values. Default value: `typeof(1.0)`."
RT = typeof(1.0)

"""
Format of real values. Default values:
- for [`RT`](@ref) = `Float64`: `"% .15E"`;
- for [`RT`](@ref) = `Float32`: `"% .6E"`;
- for [`RT`](@ref) = `Float16`: `"% .3E"`.
"""
RF = "% .6E"

if (RT == Float64)
    RF = "% .15E"
elseif (RT == Float16)
    RF = "% .3E"
end

end