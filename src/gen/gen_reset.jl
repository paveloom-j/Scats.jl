# This file contains a function to reset
# an instance to default values

"""
    reset!(gen::GenStruct)

Reset an instance of [`GenStruct`](@ref) to default values.

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.gen.example(file)
s.gen.read!(file)
s.gen.reset!()

# output


```
"""
function reset!(gen::GenStruct)

    gen.N = gen.r = 0
    gen.Δt = gen.q = gen.α = gen.β = gen.γ = 0.0
    gen.A = gen.ν = gen.ϕ = []

    nothing

end