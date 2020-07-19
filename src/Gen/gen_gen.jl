# This file contains a function to generate time series

"""
    gen!(Gen::GenStruct, Input::InputStruct)

Generate time series for an instance of [`InputStruct`](@ref) using generator
parameters from an instance of [`GenStruct`](@ref).

# Usage
```jldoctest; output = false
using Scats
s = Scats.api()
file, _ = mktemp()
s.Gen.example(file)
s.gen!()

# output


```
"""
function gen!(Gen::GenStruct, Input::InputStruct)

    # Unpack
    N = Gen.N
    Δt = Gen.Δt
    q = Gen.q
    α = Gen.α
    β = Gen.β
    r = Gen.r
    A = Gen.A
    ν = Gen.ν
    ϕ = Gen.ϕ
    γ = Gen.γ

    # Save some values in input
    Input.N = N
    Input.Δt = Δt
    Input.q = q

    # Calculate standard deviation
    σ = √(sum(A .* A) / (2 * γ))

    # Calculate auxiliary variable
    N₋₁ = N - 1

    # Check sizes of arrays
    if size(Input.t, 1) != N
        Input.t = Vector{RT}(undef, N)
    end
    if size(Input.x, 1) != N
        Input.x = Vector{RT}(undef, N)
    end

    # Auxiliary function to wrap an array for zero-based indexing
    @inline function Array(array)
        OffsetArray(array, 0:N₋₁)
    end

    # Wrap arrays from input
    ta = Array(Input.t)
    xa = Array(Input.x)

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
