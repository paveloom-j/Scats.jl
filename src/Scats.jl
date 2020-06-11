__precompile__()

# This file contains a type providing
# the main interface of the package

baremodule Scats

"""
A module containing all inner parts of this package. Is not advisable to be used directly.

"""
module internal
include("prec.jl")          # Precisions and formats of numbers
include("extras/extras.jl") # Extras
include("input/input.jl")   # Input data
include("result/result.jl") # Result data
include("gen/gen.jl")       # Generator
using .prec
using .input
using .result
using .gen
using .extras
end

using .internal: InputStruct, ResultStruct, GenStruct
import Base.!, Base.!==, Base.println

"""
    api()

Instantiate an instance of Scats API to get access to the public interface.

# Types
- [`input`](@ref Scats.internal.input.InputStruct): input data;
- [`gen`](@ref Scats.internal.gen.GenStruct): generator;
- [`result`](@ref Scats.internal.result.ResultStruct): result data.

# Methods
- for [`input`](@ref Scats.internal.input):
    - [`read_input!`](@ref Scats.internal.input.read!)`(file::AbstractString)`: read input data from a file;
    - [`write_input`](@ref Scats.internal.input.write)`(file::AbstractString)`: write input data to a file;
    - [`input_example`](@ref Scats.internal.input.example)`(file::AbstractString)`: generate an example of the input/output file.

# Usage
```julia
using Scats
s = Scats.api()
```
"""
mutable struct api

    input::InputStruct
    read_input!::Function
    write_input::Function
    input_example::Function

    gen::GenStruct
    read_gen!::Function
    gen!::Function
    gen_example::Function

    result::ResultStruct

    reset!::Function

    function api()

        this = new()

        this.input = InputStruct()
        this.read_input! = this.input.read!
        this.write_input = this.input.write
        this.input_example = this.input.example

        this.gen = GenStruct()
        this.read_gen! = this.gen.read!
        this.gen! = function() this.gen.gen!(this.gen, this.input) end
        this.gen_example = this.gen.example

        this.result = ResultStruct()

        this.reset! = function() this.input.reset!(), this.result.reset!(), this.gen.reset!() end

        this

    end

end

end