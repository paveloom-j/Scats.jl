# This file contains macros and functions
# used in the tests of this package

"""
Create a temporary file
"""
macro file()
    return esc(:((file, io) = mktemp()))
end

"""
Create an instance of the API
"""
macro instantiate()
    return esc(:(s = API()))
end

"""
Construct a function for constructing an
exception passing only a type and an ending
"""
macro construct_exceptions(prefix::AbstractString)
    return esc(quote
        """
        Construct an exception passing only a type and an ending
        """
        function construct_exceptions(
            type::AbstractString,
            ending::AbstractString
        )
            return eval(
                Meta.parse(
                    string($prefix, type, "_", ending)
                )
            )
        end
    end)
end

"""
Construct an array of exceptions passing only a type and a tuple of endings
"""
function construct_exceptions(
    type::AbstractString,
    endings::AbstractString...
)
    return construct_exceptions.(type, endings)
end

"""
Retrieve error messages from exceptions:
"""
function retrieve_messages(exceptions::Union{DataType, Tuple})
    return sprint.(showerror, exceptions)
end

"""
Append a call to a file and retrieve an error message from the exception:
"""
function retrieve_messages(exception::DataType, file::AbstractString)
    return sprint(showerror, exception(file))
end

"""
Append calls to files and retrieve error messages from exceptions:
"""
function retrieve_messages(exceptions::Tuple, file::AbstractString)
    return [ sprint(showerror, exception(file)) for exception in exceptions ]
end
