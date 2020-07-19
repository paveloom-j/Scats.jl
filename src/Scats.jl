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
module Internal

# Include source code
include("Prec.jl")          # Precisions and formats of numbers (source code)
include("Extras/Extras.jl") # Extras (source code)
include("Input/Input.jl")   # Input data (source code)
include("Result/Result.jl") # Result data (source code)
include("Gen/Gen.jl")       # Generator (source code)

# Export contents of the modules into Internal
using .Prec   # Precisions and formats of numbers (module)
using .Extras # Extras (module)
using .Input  # Input data (module)
using .Result # Result data (module)
using .Gen    # Generator (module)

end

# Import custom structure types
using .Internal: InputStruct  # A structure type to contain input data
using .Internal: ResultStruct # A structure type to contain result data
using .Internal: GenStruct    # A structure type to contain generator parameters

# Import few functions from Base
import Base.!, Base.!==, Base.println

"""
    api()

Instantiate an instance of Scats API to get access to the public interface.

# Types
- [`Input`](@ref Scats.Internal.Input.InputStruct): input data;
- [`Gen`](@ref Scats.Internal.Gen.GenStruct): generator;
- [`Result`](@ref Scats.Internal.Result.ResultStruct): result data.

# Methods
- for [`Input`](@ref Scats.Internal.Input):
    - [`read_input!`](@ref Scats.Internal.Input.read!)`(file::AbstractString)`:
        read input data from a file;
    - [`write_input`](@ref Scats.Internal.Input.write)`(file::AbstractString)`:
        write input data to a file;
    - [`input_example`](@ref Scats.Internal.Input.example)`(file::AbstractString)`:
        generate an example of the input/output file.

- for [`Gen`](@ref Scats.Internal.Gen):
    - [`read_gen!`](@ref Scats.Internal.Gen.read!)`(file::AbstractString)`:
        read generator parameters from a file;
    - [`gen_example`](@ref Scats.Internal.Gen.example)`(file::AbstractString)`:
        generate an example of a file containing the generator parameters;
    - [`gen!`](@ref Scats.Internal.Gen.gen!)`()`:
        generate time series.

# Usage
```julia
using Scats
s = Scats.api()
```
"""
mutable struct api

    # Input data
    Input::InputStruct      # A structure to contain input data
    read_input!::Function   # Read input data from a file
    write_input::Function   # Write input data to a file
    input_example::Function # Generate an example of the input/output file

    # Time series generator
    Gen::GenStruct        # A structure to contain generator parameters
    read_gen!::Function   # Read generator parameters from a file
    gen_example::Function # Generate an example of a file
                          # containing the generator parameters
    gen!::Function        # Generate time series

    # Result data
    Result::ResultStruct # A structure to contain result data

    # Reset all structures
    reset!::Function

    # Construct an object of this type
    function api()

        # Initialize new object
        this = new()

        # Initialize input data
        this.Input = InputStruct()               # A structure to contain input data
        this.read_input! = this.Input.read!      # Read input data from a file
        this.write_input = this.Input.write      # Write input data to a file
        this.input_example = this.Input.example  # Generate an example
                                                 # of the input/output file

        # Initialize result data
        this.Result = ResultStruct() # A structure to contain result data

        # Initialize time series generator
        this.Gen = GenStruct()              # A structure to contain generator parameters
        this.read_gen! = this.Gen.read!     # Read generator parameters from a file
        this.gen_example = this.Gen.example # Generate an example of a file
                                            # containing the generator parameters

        # Generate time series
        this.gen! = function ()
            this.Gen.gen!(this.Gen, this.Input)
        end

        # Reset all structures
        this.reset! = function ()
            this.Input.reset!()
            this.Result.reset!()
            this.Gen.reset!()
            nothing # Return nothing
        end

        # Return constructed object
        this

    end

end

end
