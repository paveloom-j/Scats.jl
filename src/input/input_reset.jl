# This file contains a function to reset
# an instance to default values

"""
    reset!(input::InputStruct)

Reset an instance of [`InputStruct`](@ref) to default values.

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
s.input.reset!()

# output


```
"""
function reset!(input::InputStruct)

    input.N = 0
    input.Δt = input.q = 0.0
    input.t = input.x = []

    nothing

end