# This file contains a module
# containing the types of numbers
# used in the package, and
# also their according formats

"""
Module containing the types of numbers used in
the package, and also their according formats.
"""
module Prec

# Export
export IT, RT, RF

"Type of integer values. Default value: `Int`."
IT = Int

"Type of real values. Default value: `typeof(1.0)`."
RT = typeof(1.0)

"""
Format of real values. Default values:
- for [`RT`](@ref) = `Float64`: `"% .15E"`;
- for [`RT`](@ref) = `Float32`: `"% .6E"`;
- for [`RT`](@ref) = `Float16`: `"% .3E"`.
"""
RF = "% .6E"

# Change the format according to the type of a real number
if (RT == Float64)
    RF = "% .15E"
elseif (RT == Float16)
    RF = "% .3E"
end

end
