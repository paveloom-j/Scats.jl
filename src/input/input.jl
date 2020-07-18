# This file contains
# a type for input data

"Module containing a type for storage and interaction with input data."
module input

# Export
export InputStruct

# Arrays with non-standard indexing
using OffsetArrays

# Formatted printing
using ..extras

# Precisions and formats of numbers
using ..prec

"""
    InputStruct()

Instantiate this type to interact with input data.

# Data
- `N::`[`IT`](@ref)`=0`: sample size;
- `Δt::`[`RT`](@ref)`=0`: sample step;
- `q::`[`RT`](@ref)`=0`: significance level;
- `t::Vector{`[`RT`](@ref)`}=[]`: time array;
- `x::Vector{`[`RT`](@ref)`}=[]`: values array.

# Methods
- [`read!`](@ref)`(file::AbstractString)`: read input data from a file;
- [`write`](@ref)`(file::AbstractString)`: write input data to a file;
- [`example`](@ref)`(file::AbstractString)`: generate an example of the input/output file;
- [`reset!`](@ref)`()`: reset an instance to default values.

# Note
Data can be also read when calling an instance like so:
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.input.example(file)
s.input(file)

# output


```
"""
mutable struct InputStruct

    # Data
    N::IT         # Sample size
    Δt::RT        # Sample step
    q::RT         # significance level
    t::Vector{RT} # Time array
    x::Vector{RT} # Values array

    # Methods
    read!::Function   # Read input data from a file
    write::Function   # Write input data to a file
    example::Function # Generate an example of the input/output file
    reset!::Function  # Reset an instance to default values

    # Construct an object of this type
    function InputStruct()
        this = new(0, 0, 0, [], [])
        this.read! = function(file::AbstractString) read!(this, file) end
        this.write = function(file::AbstractString) write(this, file) end
        this.example = example
        this.reset! = function() reset!(this) end
        this
    end

    # Read the data when calling an instance
    function (input::InputStruct)(file::AbstractString)
        input.read!(file)
    end

end

# Sources
include("input_exceptions.jl") # Exceptions
include("input_read.jl")       # Read input data from a file
include("input_write.jl")      # Write input data to a file
include("input_example.jl")    # Generate an example of the input/output file
include("input_reset.jl")      # Reset an instance to default values

end
