# This file contains a function to
# reset an instance to default values

"""
    reset!(Result::ResultStruct)

Reset an instance of [`ResultStruct`](@ref) to default values.

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.gen_example(file)
s.Gen(file)
s.gen!()
# Generate result data
s.Result.reset!()

# output


```
"""
function reset!(Result::ResultStruct)

    # Reset all elements
    Result.Δt = Result.q = Result.threshold = 0.0
    Result.t = Result.x = Result.X_FFT_ABS = []
    Result.ν = Result.D = Result.c = Result.cw = Result.Dw = []

    return nothing

end
