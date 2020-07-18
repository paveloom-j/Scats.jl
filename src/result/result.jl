# This file contains a type for interaction with result data

"Module containing a type for interaction with result data."
module result

# Export
export ResultStruct

# Precisions and formats of numbers
using ..prec

"""
    ResultStruct()

Instantiate this type to interact with result data.

# Data
- `Δt::`[`RT`](@ref)`=0`: sample step;
- `t::Vector{`[`RT`](@ref)`}=[]`: time array;
- `x::Vector{`[`RT`](@ref)`}=[]`: values array;
- `q::`[`RT`](@ref)`=0`: significance level;
- `threshold::`[`RT`](@ref)`=0`: signal threshold;
- `X_FFT_ABS::Vector{`[`RT`](@ref)`}=[]`: values array;
- `ν::Vector{`[`RT`](@ref)`}=[]`: periodogram frequencies array;
- `D::Vector{`[`RT`](@ref)`}=[]`: periodogram values array;
- `c::Vector{`[`RT`](@ref)`}=[]`: correlogram values array;
- `cw::Vector{`[`RT`](@ref)`}=[]`: weighted correlogram values array;
- `Dw::Vector{`[`RT`](@ref)`}=[]`: smoothed periodogram values array.

# Methods
- [`reset!`](@ref)`()`: reset an instance to default values.

"""
mutable struct ResultStruct

    # Data
    Δt::RT                # Sample step
    t::Vector{RT}         # Time array
    x::Vector{RT}         # Values array
    q::RT                 # Significance level
    threshold::RT         # Signal threshold
    X_FFT_ABS::Vector{RT} # Transformed values array
    ν::Vector{RT}         # Periodogram frequencies array
    D::Vector{RT}         # Periodogram values array
    c::Vector{RT}         # Correlogram values array
    cw::Vector{RT}        # Weighted correlogram values array
    Dw::Vector{RT}        # Smoothed periodogram values array

    # Methods
    reset!::Function # Reset an instance to default values

    # Construct an object of this type
    function ResultStruct()
        this = new(0.0, [], [], 0.0, 0.0, [], [], [], [], [])
        this.reset! = function() reset!(this) end
        this
    end

end

# Sources
include("result_reset.jl") # Reset an instance to default values

end
