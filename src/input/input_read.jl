# This file contains a function to read input data from a file

# Skip two lines, check every time for EOF.
@inline function skip(io::IO, file::AbstractString)

        # Skip one line
        readline(io)

        # Check for EOF
        if eof(io)
            throw(ScatsInputEOF(file))
        end

        # Skip one line
        readline(io)

        # Check for EOF
        if eof(io)
            throw(ScatsInputEOF(file))
        end

end

"""
    read!(input::InputStruct, file::AbstractString)

Read input data from a file to an instance of [`InputStruct`](@ref).

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.input.example(file)
s.input.read!(file)

# output


```
"""
function read!(input::InputStruct, file::AbstractString)

    # Strip the string
    file = strip(file)

    # Check if the file exists
    if !isfile(file)
        throw(ScatsInputNotAFile(file))
    end

    # Open the file for reading
    open(file, "r") do f

        # Check for EOF
        if eof(f)
            throw(ScatsInputEOF(file))
        end

        readline(f)

        # Check for EOF
        if eof(f)
            throw(ScatsInputEOF(file))
        end

        # Read `N`
        try
            input.N = parse(IT, split(readline(f))[1])
        catch
            throw(ScatsInputWR_N(file))
        end

        skip(f, file)

        # Read `Δt`
        try
            input.Δt = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsInputWR_Δt(file))
        end

        skip(f, file)

        # Read `q`
        try
            input.q = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsInputWR_q(file))
        end

        skip(f, file)

        # Read `t`
        try
            input.t = (parse.(RT, split(readline(f))[1:input.N]))
        catch
            throw(ScatsInputWR_t(file))
        end

        skip(f, file)

        # Read `x`
        try
            input.x = (parse.(RT, split(readline(f))[1:input.N]))
        catch
            throw(ScatsInputWR_x(file))
        end

    end

    nothing

end