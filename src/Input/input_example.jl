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

    open(file, "w") do f

        # Print
        println(f, "Sample size")
        println(f, "230")
        println(f)
        println(f, "Sample step")
        println(f, "0.100000000000000E+01")
        println(f)
        println(f, "Significance level")
        println(f, "0.100000000000000E-01")
        println(f)
        println(f, "Time array")
        println(f, Array{RT}([i for i in 0:229]))
        println(f)
        println(f, "Values array")
        println(f, Array{RT}([i for i in 0:229]))

    end

end
