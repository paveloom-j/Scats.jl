# This file contains function to generate an example
# of a file containing the generator parameters

"""
    example(file::AbstractString)

Generate an example of a file containing the generator parameters.

# Usage
```jldoctest; output = false
using Scats
s = Scats.API()
file, _ = mktemp()
s.Gen.example(file)

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

    open(file, "w") do io
        println(io,
        """
        Sample size
        230

        Sample step
        1.0

        Significance level
        0.01

        Parameter α of a linear trend
        0.1

        Parameter β of a linear trend
        0.05

        Number of harmonics
        1

        Amplitudes array
        1.0

        Frequencies array
        0.1

        Phase shifts array
        0.0

        «Signal-to-noise» ratio
        0.50"""
        )
    end

end
