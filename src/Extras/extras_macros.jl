"""
Construct an exception
"""
macro exception(
    docstring::AbstractString,
    name::AbstractString,
    error_message::AbstractString
)
    return esc(
        Meta.parse("""
        begin
        \"\"\"
            $name <: Exception

        $docstring

        \"\"\"
        mutable struct $name <: Exception
            file::AbstractString
            $name(file::AbstractString) = new(file)

        end

        Base.showerror(io::IO, e::$name) =
        print(io, string("\n\n", "Scats.Internal.$name:\n", "$error_message\n"))

        end""")
    )
end
