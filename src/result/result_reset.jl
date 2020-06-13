# This file contains a function to
# reset an instance to default values

"""
    reset!(result::ResultStruct)

Reset an instance of [`ResultStruct`](@ref) to default values.

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.gen_example(file)
s.gen(file)
s.gen!()
# generate result data
s.result.reset!()

# output


```
"""
function reset!(result::ResultStruct)

    result.Δt = result.q = result.threshold = 0.0
    result.t = result.x = result.X_FFT_ABS = []
    result.ν = result.D = result.c = result.cw = result.Dw = []

    nothing

end