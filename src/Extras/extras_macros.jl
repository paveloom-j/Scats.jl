"""
Construct an exception
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
