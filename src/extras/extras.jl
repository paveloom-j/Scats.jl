# This file contains extras

"Module containing extras for the package."
module extras
export println

using Formatting # Formatted printing
import Base.println # Base `println` function

using ..prec # Precisions

# Sources
include("extras_fmt.jl") # `println` extensions for real numbers

end