# This file contains function to generate an example
# of a file containing the generator parameters

"""
    example(file::AbstractString)

Generate an example of a file containing the generator parameters.

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.gen.example(file)

# output


```

"""
function example(file::AbstractString)

    # Strip the string
    file = strip(file)

    # Check is it's a directory
    if isdir(file)
        throw(ScatsGenIsADir(file))
    end

    # Print
    open(file, "w") do f

        println(f, "Sample size")
        println(f, "230")
        println(f)
        println(f, "Sample step")
        println(f, "1.0")
        println(f)
        println(f, "Significance level")
        println(f, "0.01")
        println(f)
        println(f, "Parameter α of a linear trend")
        println(f, "0.1")
        println(f)
        println(f, "Parameter β of a linear trend")
        println(f, "0.05")
        println(f)
        println(f, "Number of harmonics")
        println(f, "1")
        println(f)
        println(f, "Amplitudes array")
        println(f, "1.0")
        println(f)
        println(f, "Frequencies array")
        println(f, "0.1")
        println(f)
        println(f, "Phase shifts array")
        println(f, "0.0")
        println(f)
        println(f, "«Signal-to-noise» ratio")
        println(f, "0.50")

    end

end
