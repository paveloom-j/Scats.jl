# This file contains a function to generate time series

"""
    @array(array::AbstractString)

Wrap an array for zero-based indexing.

# Usage

```jldoctest; output = false
using OffsetArrays
using Scats.Internal.Input: InputStruct
using Scats.Internal.Gen: @array

file, _ = mktemp()
Input = InputStruct()

Input.example(file)
Input(file)

N₋₁ = Input.N - 1
@array("Input.t") === OffsetArray(Input.t, 0:N₋₁)

# output

true
```
"""
macro array(array::AbstractString)
    return esc(Meta.parse("OffsetArray($array, 0:N₋₁)"))
end

"""
    gen!(Gen::GenStruct, Input::InputStruct)

Generate time series for an instance of [`InputStruct`](@ref) using generator
parameters from an instance of [`GenStruct`](@ref).

# Usage

```jldoctest; output = false
using Scats
s = Scats.API()
file, _ = mktemp()
s.Gen.example(file)
s.gen!()

# output


```
"""
function gen!(Gen::GenStruct, Input::InputStruct)

    @unpack "Gen" "N" "Δt" "q" "α" "β" "r" "A" "ν" "ϕ" "γ"

    # Save some values in input
    @pack "Input" "N" "Δt" "q"

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

    # Wrap arrays from input
    ta = @array "Input.t"
    xa = @array "Input.x"

    # Generate random numbers array
    rng = MersenneTwister()
    rand = @array "randn(rng, RT, N)"

    # Generate time series
    for k in 0:N₋₁

        # Calculate current time moment
        t = Δt * k

        # Write it in the array
        ta[k] = t

        # Calculate the linear trend part
        c = α + β * t

        # Add the harmonics part
        for l in 1:r
            c = c + A[l] * cos(2 * π * ν[l] * t - ϕ[l])
        end

        # Add the noise part
        c = c + rand[k]

        # Write a result in the array
        xa[k] = c

    end

end
