# This file contains extras: auxiliary
# functions and macros used within the package

"Module containing extras: auxiliary functions
and macros used within the package."
module Extras

# Export
export println, @exception, @unpack, @pack

# Formatted printing
using Formatting

# Precisions and formats of numbers
using ..Prec

# Sources
include("extras_macros.jl") # A macro to create extensions
include("extras_fmt.jl")    # An extension of println for real numbers (RT)

end
