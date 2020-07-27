# This file contains a function to
# read generator parameters from a file

"""
    @skip()

Skip two lines and check for EOF each time.

# Usage

```julia
using Scats.Internal.Gen: @skip

@skip() #= ===
begin
    readline(io)
    if eof(io)
        throw(ScatsGenEOF(file))
    end
    readline(io)
    if eof(io)
        throw(ScatsGenEOF(file))
    end
end =#
```
"""
macro skip()
    return esc(quote
        readline(io)
        if eof(io)
            throw(ScatsGenEOF(file))
        end
        readline(io)
        if eof(io)
            throw(ScatsGenEOF(file))
        end
    end)
end

"""
    @read(element::AbstractString, type::AbstractString)

Read a scalar element.

# Usage

```julia
using Scats.Internal.Gen: @read

@read("N", "IT") #= ===
begin
    try
        Gen.N = parse(IT, split(readline(io))[1])
    catch
        throw(ScatsGenWR_N(file))
    end
end =#
```
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
    @read_array(element::AbstractString, type::AbstractString)

Read an array element.

# Usage

```julia
using Scats.Internal.Gen: @read_array

@read_array("A", "RT") #= ===
begin
    try
        Gen.A = parse.(RT, split(readline(io))[1:Gen.r])
    catch
        throw(ScatsGenWR_A(file))
    end
end =#
```
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
