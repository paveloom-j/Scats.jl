# This file contains a function to generate time series

"""
    gen!(gen::GenStruct, input::InputStruct)

Generate time series for an instance of [`InputStruct`](@ref).

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.gen.example(file)
s.gen!()

# output


```
"""
function gen!(gen::GenStruct, input::InputStruct)

    # Unpack
    N = gen.N
    Δt = gen.Δt
    q = gen.q
    α = gen.α
    β = gen.β
    r = gen.r
    A = gen.A
    ν = gen.ν
    ϕ = gen.ϕ
    γ = gen.γ

    # Save some values in input
    input.N = N
    input.Δt = Δt
    input.q = q

    # Calculate standard deviation
    σ = √(sum(A .* A) / (2 * γ))

    # Calculate auxiliary variable
    N₋₁ = N - 1

    # Check sizes of arrays
    if size(input.t, 1) != N
        input.t = Vector{RT}(undef, N)
    end
    if size(input.x, 1) != N
        input.x = Vector{RT}(undef, N)
    end

    # Auxiliary function to wrap an array for zero-based indexing
    @inline function Array(array)
        OffsetArray(array, 0:N₋₁)
    end

    # Wrap arrays from input
    ta = Array(input.t)
    xa = Array(input.x)

    # Generate random numbers array
    rng = MersenneTwister()
    rand = Array(randn(rng, RT, N))

    # Generate time series
    for k in 0:N₋₁

        t = Δt * k
        ta[k] = t

        c = α + β * t

        for l in 1:r

            c = c + A[l] * cos(2 * π * ν[l] * t - ϕ[l])

        end

        c = c + rand[k]

        xa[k] = c

    end

end