# This file contains a type providing
# the main interface of the package

# Precompile the package
__precompile__()

"""
A package for completing spectral correlation analysis of time series.

Links:
- Repo: https://github.com/paveloom-j/Scats.jl
- Docs: https://paveloom-j.github.io/Scats.jl

Please, use the published docs instead of retrieving
information from these docstrings manually.
"""
baremodule Scats

"""
A module containing all inner parts of this package. Is not advisable to be used directly.

See documentation for more info about its contents.
"""
module internal

# Include source code
include("prec.jl")          # Precisions and formats of numbers (source code)
include("extras/extras.jl") # Extras (source code)
include("input/input.jl")   # Input data (source code)
include("result/result.jl") # Result data (source code)
include("gen/gen.jl")       # Generator (source code)

# Export contents of the modules into internal
using .prec   # Precisions and formats of numbers (module)
using .extras # Generator (source code)
using .input  # Input data (module)
using .result # Result data (module)
using .gen    # Generator (source code)

end

# Import custom structure types
using .internal: InputStruct  # A structure type to contain input data
using .internal: ResultStruct # A structure type to contain generator parameters
using .internal: GenStruct    # A structure type to contain result data

# Import few functions from Base
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
    - [`read_input!`](@ref Scats.internal.input.read!)`(file::AbstractString)`:
        read input data from a file;
    - [`write_input`](@ref Scats.internal.input.write)`(file::AbstractString)`:
        write input data to a file;
    - [`input_example`](@ref Scats.internal.input.example)`(file::AbstractString)`:
        generate an example of the input/output file.

- for [`gen`](@ref Scats.internal.gen):
    - [`read_gen!`](@ref Scats.internal.gen.read!)`(file::AbstractString)`:
        read generator parameters from a file;
    - [`gen_example`](@ref Scats.internal.gen.example)`(file::AbstractString)`:
        generate an example of a file containing the generator parameters;
    - [`gen!`](@ref Scats.internal.gen.gen!)`()`:
        generate time series.

# Usage
```julia
using Scats
s = Scats.api()
```
"""
mutable struct api

    # Input data
    input::InputStruct      # A structure to contain input data
    read_input!::Function   # Read input data from a file
    write_input::Function   # Write input data to a file
    input_example::Function # Generate an example of the input/output file

    # Time series generator
    gen::GenStruct        # A structure to contain generator parameters
    read_gen!::Function   # Read generator parameters from a file
    gen_example::Function # Generate an example of a file
                          # containing the generator parameters
    gen!::Function        # Generate time series

    # Result data
    result::ResultStruct # A structure to contain result data

    # Reset all structures
    reset!::Function

    # Instantiate an instance of Scats API
    function api()

        # Initialize new object
        this = new()

        # Initialize input data
        this.input = InputStruct()               # A structure to contain input data
        this.read_input! = this.input.read!      # Read input data from a file
        this.write_input = this.input.write      # Write input data to a file
        this.input_example = this.input.example  # Generate an example
                                                 # of the input/output file

        # Initialize time series generator
        this.gen = GenStruct()              # A structure to contain generator parameters
        this.read_gen! = this.gen.read!     # Read generator parameters from a file
        this.gen_example = this.gen.example # Generate an example of a file
                                            # containing the generator parameters

        # Generate time series
        this.gen! = function ()
            this.gen.gen!(this.gen, this.input)
        end

        # Initialize result data
        this.result = ResultStruct() # A structure to contain result data

        # Reset all structures
        this.reset! = function ()
            this.input.reset!()
            this.result.reset!()
            this.gen.reset!()
            nothing
        end

        # Return constructed object
        this

    end

end

end
