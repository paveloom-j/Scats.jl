# This file contains a function to
# read generator parameters from a file

# Skip two lines and check for EOF each time
@inline function skip(io::IO, file::AbstractString)

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
    read!(gen::GenStruct, file::AbstractString)

Read generator parameters from a file to an instance of [`InputStruct`](@ref)

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.gen.example(file)
s.gen.read!(file)

# output


```
"""
function read!(gen::GenStruct, file::AbstractString)

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
            gen.N = parse(IT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_N(file))
        end

        skip(f, file)

        # Read Δt
        try
            gen.Δt = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_Δt(file))
        end

        skip(f, file)

        # Read q
        try
            gen.q = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_q(file))
        end

        skip(f, file)

        # Read α
        try
            gen.α = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_α(file))
        end

        skip(f, file)

        # Read β
        try
            gen.β = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_β(file))
        end

        skip(f, file)

        # Read r
        try
            gen.r = parse(IT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_r(file))
        end

        skip(f, file)

        # Read A
        try
            gen.A = (parse.(RT, split(readline(f))[1:gen.r]))
        catch
            throw(ScatsGenWR_A(file))
        end

        skip(f, file)

        # Read ν
        try
            gen.ν = (parse.(RT, split(readline(f))[1:gen.r]))
        catch
            throw(ScatsGenWR_ν(file))
        end

        skip(f, file)

        # Read ϕ
        try
            gen.ϕ = (parse.(RT, split(readline(f))[1:gen.r]))
        catch
            throw(ScatsGenWR_ϕ(file))
        end

        skip(f, file)

        # Read γ
        try
            gen.γ = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_γ(file))
        end

    end

    nothing

end