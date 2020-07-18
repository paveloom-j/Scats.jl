# This file contains a type for
# interacting with the generator

"Module containing a type for interaction with the time series generator."
module gen

# Export
export GenStruct, gen!

# Random numbers
using Random

# Arrays with non-standard indexing
using OffsetArrays

# Precisions and formats of numbers
using ..prec

# Input data
using ..input

"""
    GenStruct()

Instantiate this type to interact with the time series generator.

# Data
- `N::`[`IT`](@ref)`=0`: sample size;
- `Δt::`[`RT`](@ref)`=0`: sample step;
- `q::`[`RT`](@ref)`=0`: significance level;
- `α::`[`RT`](@ref)`=0`: parameter α of a linear trend;
- `β::`[`RT`](@ref)`=0`: parameter β of a linear trend;
- `r::`[`IT`](@ref)`=0`: number of harmonics;
- `A::Vector{`[`RT`](@ref)`}=[]`: amplitudes array;
- `ν::Vector{`[`RT`](@ref)`}=[]`: frequencies array;
- `ϕ::Vector{`[`RT`](@ref)`}=[]`: phase shifts array;
- `γ::`[`RT`](@ref)`=0`: «signal-to-noise» ratio.

# Methods
- [`read!`](@ref)`(file::AbstractString)`: read generator parameters from a file;
- [`example`](@ref)`(file::AbstractString)`: generate an example of a file containing
  the generator parameters;
- [`gen!`](@ref)`()`: generate time series;
- [`reset!`](@ref)`()`: reset an instance to default values.

# Note
Data can be also read when calling an instance like so:
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.gen.example(file)
s.gen(file)

# output


```
"""
mutable struct GenStruct

    # Data
    N::IT         # Sample size
    Δt::RT        # Sample step
    q::RT         # Significance level
    α::RT         # Parameter α of a linear trend
    β::RT         # Parameter β of a linear trend
    r::IT         # Number of harmonics
    A::Vector{RT} # Amplitudes array
    ν::Vector{RT} # Frequencies array
    ϕ::Vector{RT} # Phase shifts array
    γ::RT         # «Signal-to-noise» ratio

    # Methods
    read!::Function   # Read generator parameters from a file
    example::Function # Generate an example of a file containing the generator parameters
    gen!::Function    # Generate time series
    reset!::Function  # Reset an instance to default values

    # Constructor
    function GenStruct()
        this = new(0, 0, 0, 0, 0, 0, [], [], [], 0)
        this.read! = function(file::AbstractString) read!(this, file) end
        this.example = example
        this.gen! = function(gen::GenStruct, input::InputStruct) gen!(this, input) end
        this.reset! = function() reset!(this) end
        this
    end

    # Read the parameters when calling an instance
    function (gen::GenStruct)(file::AbstractString)
        gen.read!(file)
    end

end

# Sources
include("gen_exceptions.jl") # Exceptions
include("gen_read.jl")       # Read generator parameters from a file
include("gen_example.jl")    # Generate an example of a file containing
                             # the generator parameters
include("gen_gen.jl")        # Generate time series
include("gen_reset.jl")      # Reset an instance to default values

end
