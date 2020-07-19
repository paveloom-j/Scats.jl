# This file contains extras: auxiliary
# functions used within the package

"Module containing extras: auxiliary functions used within the package."
module Extras

# Export
export println

using Formatting # Formatted printing

import Base.println # Import standard println

using ..prec # Precisions and formats of numbers

# Sources
include("extras_fmt.jl") # An extension of println for real numbers (RT)

end
