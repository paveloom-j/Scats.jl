# This file contains a function to
# read generator parameters from a file

"""
Skip two lines and check for EOF each time
"""
macro skip()
    return esc(quote
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
    end)
end

"""
Read a scalar element
"""
macro read(element::AbstractString, type::AbstractString)
    return esc(
        Meta.parse("""
        try
            Gen.$element = parse($type, split(readline(io))[1])
        catch
            throw(ScatsGenWR_$element(file))
        end
        """)
    )
end

"""
Read an array element
"""
macro read_array(element::AbstractString, type::AbstractString)
    return esc(
        Meta.parse("""
        try
            Gen.$element = parse.($type, split(readline(io))[1:Gen.r])
        catch
            throw(ScatsGenWR_$element(file))
        end
        """)
    )
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
    open(file, "r") do io

        # Check for EOF
        if eof(io)
            throw(ScatsGenEOF(file))
        end

        readline(io)

        # Check for EOF
        if eof(io)
            throw(ScatsGenEOF(file))
        end

        @read "N" "IT"
        @skip

        @read "Δt" "RT"
        @skip

        @read "q" "RT"
        @skip

        @read "α" "RT"
        @skip

        @read "β" "RT"
        @skip

        @read "r" "IT"
        @skip

        @read_array "A" "RT"
        @skip

        @read_array "ν" "RT"
        @skip

        @read_array "ϕ" "RT"
        @skip

        @read "γ" "RT"

    end

    return nothing

end
