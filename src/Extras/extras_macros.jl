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

Unpack an instance of struct on the specified fields.
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
