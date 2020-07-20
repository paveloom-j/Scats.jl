# This file contains a function to
# read generator parameters from a file

# Skip two lines and check for EOF each time
@inline function _skip(io::IO, file::AbstractString)

    # Skip a line
    readline(io)

    # Check for EOF
    if eof(io)
        throw(ScatsGenEOF(file))
    end

    # Skip a line
    readline(io)

    # Check for EOF
    if eof(io)
        throw(ScatsGenEOF(file))
    end

end

"""
    read!(Gen::GenStruct, file::AbstractString)

Read generator parameters from a file to an instance of [`GenStruct`](@ref).

# Usage
```jldoctest; output = false
using Scats
s = Scats.API()
file, _ = mktemp()
s.Gen.example(file)
s.Gen.read!(file)

# output


```
"""
function read!(Gen::GenStruct, file::AbstractString)

    # Strip the line
    file = strip(file)

    # Check if the file exists
    if !isfile(file)
        throw(ScatsGenNotAFile(file))
    end

    # Open a file for reading
    open(file, "r") do f

        # Check for EOF
        if eof(f)
            throw(ScatsGenEOF(file))
        end

        readline(f)

        # Check for EOF
        if eof(f)
            throw(ScatsGenEOF(file))
        end

        # Read N
        try
            Gen.N = parse(IT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_N(file))
        end

        _skip(f, file)

        # Read Δt
        try
            Gen.Δt = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_Δt(file))
        end

        _skip(f, file)

        # Read q
        try
            Gen.q = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_q(file))
        end

        _skip(f, file)

        # Read α
        try
            Gen.α = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_α(file))
        end

        _skip(f, file)

        # Read β
        try
            Gen.β = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_β(file))
        end

        _skip(f, file)

        # Read r
        try
            Gen.r = parse(IT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_r(file))
        end

        _skip(f, file)

        # Read A
        try
            Gen.A = (parse.(RT, split(readline(f))[1:Gen.r]))
        catch
            throw(ScatsGenWR_A(file))
        end

        _skip(f, file)

        # Read ν
        try
            Gen.ν = (parse.(RT, split(readline(f))[1:Gen.r]))
        catch
            throw(ScatsGenWR_ν(file))
        end

        _skip(f, file)

        # Read ϕ
        try
            Gen.ϕ = (parse.(RT, split(readline(f))[1:Gen.r]))
        catch
            throw(ScatsGenWR_ϕ(file))
        end

        _skip(f, file)

        # Read γ
        try
            Gen.γ = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_γ(file))
        end

    end

    return nothing

end
