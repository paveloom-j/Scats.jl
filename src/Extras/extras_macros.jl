"""
    @exception(
        docstring::AbstractString,
        module_name::AbstractString,
        exception_name::AbstractString,
        error_message::AbstractString,
    )

Construct an exception.

# Usage

```julia
using Scats.Internal.Extras: @exception
@exception(
    "Exception thrown when the file is not found.",
    "Gen",
    "ScatsGenNotAFile",
    "The file is not found (\\\"\", e.file, \"\\\").",
)
```

This macro call is equivalent to this exception definition:

```jldoctest; output = false
\"\"\"
    ScatsGenNotAFile <: Exception

Exception thrown when the file is not found.

\"\"\"
mutable struct ScatsGenNotAFile <: Exception
    file::AbstractString
    ScatsGenNotAFile(file::AbstractString) = new(file)
end

Base.showerror(io::IO, e::ScatsGenNotAFile) =
print(
    io, string(
        "\\n\\n",
        "Scats.Internal.Gen.ScatsGenNotAFile:\\n",
        "The file is not found (\\\"\", e.file, \"\\\").\\n"
    )
)

# output


```
"""
macro exception(
    docstring::AbstractString,
    module_name::AbstractString,
    exception_name::AbstractString,
    error_message::AbstractString,
)
    return esc(
        Meta.parse("""
        begin
        \"\"\"
            $exception_name <: Exception

        $docstring

        \"\"\"
        mutable struct $exception_name <: Exception
            file::AbstractString
            $exception_name(file::AbstractString) = new(file)
        end

        Base.showerror(io::IO, e::$exception_name) =
        print(
            io, string(
                "\n\n",
                "Scats.Internal.$module_name.$exception_name:\n",
                "$error_message\n"
            )
        )

        end""")
    )
end


"""
    @unpack(
        struct_instance::AbstractString,
        fields::AbstractString...,
    )

Unpack an instance of a structure on the specified fields.

# Usage

```jldoctest; output = false
using Scats.Internal.Extras: @unpack
using Scats.Internal.Gen: GenStruct
Gen = GenStruct()

@unpack "Gen" "N" "Δt" "q" "α" "β" "r" "A" "ν" "ϕ" "γ"

# output

0.0
```

This macro call is equivalent to the following set of assignments:

```jldoctest; output = false
using Scats.Internal.Gen: GenStruct
Gen = GenStruct()

# @unpack "Gen" "N" "Δt" "q" "α" "β" "r" "A" "ν" "ϕ" "γ" ==
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

# output

0.0
```
"""
macro unpack(
    struct_instance::AbstractString,
    fields::AbstractString...,
)
    result_string = string(
        "begin\n",
        join(
            [ "$field = $struct_instance.$field\n" for field in fields ]
        ),
        "end"
    )
    return esc(Meta.parse(result_string))
end

"""
    @pack(
        struct_instance::AbstractString,
        fields::AbstractString...,
    )

Pack the specified variables in the structure instance fields of the same name.

# Usage

```jldoctest; output = false
using Scats.Internal.Extras: @pack
using Scats.Internal.Input: InputStruct
Input = InputStruct()

N = 230
Δt = 1
q = 0.01

@pack "Input" "N" "Δt" "q"

# output

0.01
```

This macro call is equivalent to the following set of assignments:

```jldoctest; output = false
using Scats.Internal.Input: InputStruct
Input = InputStruct()

N = 230
Δt = 1
q = 0.01

# @pack "Input" "N" "Δt" "q" ==
Input.N = N
Input.Δt = Δt
Input.q = q

# output

0.01
```
"""
macro pack(
    struct_instance::AbstractString,
    fields::AbstractString...,
)
    result_string = string(
        "begin\n",
        join(
            [ "$struct_instance.$field = $field\n" for field in fields ]
        ),
        "end"
    )
    return esc(Meta.parse(result_string))
end
