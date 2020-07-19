# This file contains a function to reset
# an instance to default values

"""
    reset!(Gen::GenStruct)

Reset an instance of [`GenStruct`](@ref) to default values.

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.Gen.example(file)
s.Gen.read!(file)
s.Gen.reset!()

# output


```
"""
function reset!(Gen::GenStruct)

    # Reset all elements
    Gen.N = Gen.r = 0
    Gen.Δt = Gen.q = Gen.α = Gen.β = Gen.γ = 0
    Gen.A = Gen.ν = Gen.ϕ = []

    return nothing

end
