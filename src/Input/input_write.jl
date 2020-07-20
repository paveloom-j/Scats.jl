# This file contains a function
# to write input data to a file

"""
    write(input::InputStruct, file::AbstractString)

Write input data from an instance of [`InputStruct`](@ref) to a file.

# Usage
```jldoctest; output = false
using Scats
s = Scats.API()
file, _ = mktemp()
s.Input.write(file)

# output


```
"""
function write(input::InputStruct, file::AbstractString)

    open(file, "w") do f

        # Print
        println(f, "Sample size")
        println(f, input.N)
        println(f, "\nSample step")
        println(f, input.Δt)
        println(f, "\nSignificance level")
        println(f, input.q)
        println(f, "\nTime array")
        println(f, input.t)
        println(f, "\nValues array")
        println(f, input.x)

    end

end
