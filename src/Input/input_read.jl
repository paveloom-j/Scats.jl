# This file contains a function to read input data from a file

"""
Skip two lines and check for EOF each time.
"""
macro skip()
    return esc(quote
        # Skip a line
        readline(io)

        # Check for EOF
        if eof(io)
            throw(ScatsInputEOF(file))
        end

        # Skip a line
        readline(io)

        # Check for EOF
        if eof(io)
            throw(ScatsInputEOF(file))
        end
    end)
end

"""
Read a scalar element.
"""
macro read(element::AbstractString, type::AbstractString)
    return esc(
        Meta.parse("""
        try
            Input.$element = parse($type, split(readline(io))[1])
        catch
            throw(ScatsInputWR_$element(file))
        end
        """)
    )
end

"""
Read an array element.
"""
macro read_array(element::AbstractString, type::AbstractString)
    return esc(
        Meta.parse("""
        try
            Input.$element = parse.($type, split(readline(io))[1:Input.N])
        catch
            throw(ScatsInputWR_$element(file))
        end
        """)
    )
end

"""
    read!(Input::InputStruct, file::AbstractString)

Read input data from a file to an instance of [`InputStruct`](@ref).

# Usage
```jldoctest; output = false
using Scats
s = Scats.API()
file, _ = mktemp()
s.Input.example(file)
s.Input.read!(file)

# output


```
"""
function read!(Input::InputStruct, file::AbstractString)

    # Strip the string
    file = strip(file)

    # Check if the file exists
    if !isfile(file)
        throw(ScatsInputNotAFile(file))
    end

    # Open the file for reading
    open(file, "r") do io

        # Check for EOF
        if eof(io)
            throw(ScatsInputEOF(file))
        end

        readline(io)

        # Check for EOF
        if eof(io)
            throw(ScatsInputEOF(file))
        end

        @read "N" "IT"
        @skip

        @read "Δt" "RT"
        @skip

        @read "q" "RT"
        @skip

        @read_array "t" "RT"
        @skip

        @read_array "x" "RT"

    end

    return nothing

end
