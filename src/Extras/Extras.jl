# This file contains extras: auxiliary
# functions used within the package

"Module containing extras: auxiliary functions used within the package."
module Extras

# Export
export println, @exception

# Formatted printing
using Formatting

# Precisions and formats of numbers
using ..Prec

# Sources
include("extras_macros.jl") # A macro to create extensions
include("extras_fmt.jl")    # An extension of println for real numbers (RT)

end
