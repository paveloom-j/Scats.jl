# This file contains extensions for base `println`
# which make it easy to print real values and arrays

"""
    println(io::IO, value::RT)

Print an [`RT`](@ref) value.

# Usage
```jldoctest
using Scats: internal.Prec.RT, internal.Extras.println
x = RT(1.0)
println(x)

# output

 1.000000000000000E+00
```

Note: this doctest requires x64 architecture.
"""
function println(io::IO, value::RT)
    println(io, sprintf1(RF, value))
end

"""
    println(io::IO, array::Array{RT, 1})

Print an array containing [`RT`](@ref) values.

# Usage
```jldoctest
using Scats: internal.Prec.RT, internal.Extras.println
x = Array{RT}([1.0, 2.0, 3.0])
println(x)

# output

 1.000000000000000E+00    2.000000000000000E+00    3.000000000000000E+00
```

Note: this doctest requires x64 architecture.
"""
function println(io::IO, array::Vector{RT})
    println(io, join([sprintf1(RF, s) for s in array], " "^3))
end
