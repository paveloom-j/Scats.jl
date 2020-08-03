# This file contains the definition of a function
# to generate an example of the input/output file

"""
    example(file::AbstractString)

Generate an example of the input/output file.

# Usage

```jldoctest; output = false
using Scats
s = Scats.API()
file, _ = mktemp()
s.Input.example(file)

# output


```

See: [`InputStruct`](@ref).
"""
function example(file::AbstractString)

    # Strip the string
    file = strip(file)

    # Check if it's a directory
    if isdir(file)
        throw(ScatsInputIsADir(file))
    end

    open(file, "w") do io
        # Print
        println(io, "Sample size")
        println(io, "230")
        println(io)
        println(io, "Sample step")
        println(io, RT(1))
        println(io)
        println(io, "Significance level")
        println(io, RT(0.01))
        println(io)
        println(io, "Time array")
        println(io, Array{RT}([i for i in 0:229]))
        println(io)
        println(io, "Values array")
        println(io, Array{RT}([i for i in 0:229]))
    end

end
