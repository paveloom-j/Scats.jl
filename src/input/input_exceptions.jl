# This file contains custom exceptions
# for functions related to input data

"""
    ScatsInputNotAFile <: Exception

Exception thrown when the file is not found.

"""
mutable struct ScatsInputNotAFile <: Exception
    file::AbstractString
    ScatsInputNotAFile(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputNotAFile) =
print(io, "\n
Scats.internal.ScatsInputNotAFile:
The file is not found (\"", e.file, "\").\n")

"""
    ScatsInputIsADir <: Exception

Exception thrown when the path is a directory.

"""
mutable struct ScatsInputIsADir <: Exception
    file::AbstractString
    ScatsInputIsADir(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputIsADir) =
print(io, "\n
Scats.internal.ScatsInputIsADir:
Specified path is a directory (\"", e.file, "\").\n")

"""
    ScatsInputEOF <: Exception

Exception thrown when an end of file occurred.

"""
mutable struct ScatsInputEOF <: Exception
    file::AbstractString
    ScatsInputEOF(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputEOF) =
print(io, "\n
Scats.internal.ScatsInputEOF:
Unexpected end of file (\"", e.file, "\").\n")

"""
    ScatsInputWR_N <: Exception

Exception thrown when an input for `N` is wrong.

"""
mutable struct ScatsInputWR_N <: Exception
    file::AbstractString
    ScatsInputWR_N(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_N) =
print(io, "\n
Scats.internal.ScatsInputWR_N:
Wrong input: N (\"", e.file, "\").\n")

"""
    ScatsInputWR_Δt <: Exception

Exception thrown when an input for `Δt` is wrong.

"""
mutable struct ScatsInputWR_Δt <: Exception
    file::AbstractString
    ScatsInputWR_Δt(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_Δt) =
print(io, "\n
Scats.internal.ScatsInputWR_Δt:
Wrong input: Δt (\"", e.file, "\").\n")

"""
    ScatsInputWR_q <: Exception

Exception thrown when an input for `q` is wrong.

"""
mutable struct ScatsInputWR_q <: Exception
    file::AbstractString
    ScatsInputWR_q(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_q) =
print(io, "\n
Scats.internal.ScatsInputWR_q:
Wrong input: q (\"", e.file, "\").\n")

"""
    ScatsInputWR_t <: Exception

Exception thrown when an input for `t` is wrong.

"""
mutable struct ScatsInputWR_t <: Exception
    file::AbstractString
    ScatsInputWR_t(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_t) =
print(io, "\n
Scats.internal.ScatsInputWR_t:
Wrong input: t (\"", e.file, "\").\n")

"""
    ScatsInputWR_x <: Exception

Exception thrown when an input for `x` is wrong.

"""
mutable struct ScatsInputWR_x <: Exception
    file::AbstractString
    ScatsInputWR_x(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_x) =
print(io, "\n
Scats.internal.ScatsInputWR_x:
Wrong input: x (\"", e.file, "\").\n")
