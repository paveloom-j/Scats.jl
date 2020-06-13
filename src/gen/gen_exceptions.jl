# This file contains exceptions for methods
# related to the time series generator

"""
    ScatsGenNotAFile <: Exception

Exception thrown when the file is not found.

"""
mutable struct ScatsGenNotAFile <: Exception
    file::AbstractString
    ScatsGenNotAFile(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenNotAFile) =
print(io, "\n\nScats.internal.ScatsGenNotAFile:\nThe file is not found (\"", e.file, "\").\n")

"""
    ScatsGenIsADir <: Exception

Exception thrown when the path is a directory.

"""
mutable struct ScatsGenIsADir <: Exception
    file::AbstractString
    ScatsGenIsADir(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenIsADir) =
print(io, "\n\nScats.internal.ScatsGenIsADir:\nSpecified path is a directory (\"", e.file, "\").\n")

"""
    ScatsGenEOF <: Exception

Exception thrown when an end of file occurred.

"""
mutable struct ScatsGenEOF <: Exception
    file::AbstractString
    ScatsGenEOF(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenEOF) =
print(io, "\n\nScats.internal.ScatsGenEOF:\nUnexpected end of file (\"", e.file, "\").\n")

"""
    ScatsGenWR_N <: Exception

Exception thrown when an input for `N` is wrong.

"""
mutable struct ScatsGenWR_N <: Exception
    file::AbstractString
    ScatsGenWR_N(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_N) =
print(io, "\n\nScats.internal.ScatsGenWR_N:\nWrong input: N (\"", e.file, "\").\n")

"""
    ScatsGenWR_Δt <: Exception

Exception thrown when an input for `Δt` is wrong.

"""
mutable struct ScatsGenWR_Δt <: Exception
    file::AbstractString
    ScatsGenWR_Δt(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_Δt) =
print(io, "\n\nScats.internal.ScatsGenWR_Δt:\nWrong input: Δt (\"", e.file, "\").\n")

"""
    ScatsGenWR_q <: Exception

Exception thrown when an input for `q` is wrong.

"""
mutable struct ScatsGenWR_q <: Exception
    file::AbstractString
    ScatsGenWR_q(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_q) =
print(io, "\n\nScats.internal.ScatsGenWR_q:\nWrong input: q (\"", e.file, "\").\n")

"""
    ScatsGenWR_α <: Exception

Exception thrown when an input for `α` is wrong.

"""
mutable struct ScatsGenWR_α <: Exception
    file::AbstractString
    ScatsGenWR_α(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_α) =
print(io, "\n\nScats.internal.ScatsGenWR_α:\nWrong input: α (\"", e.file, "\").\n")

"""
    ScatsGenWR_β <: Exception

Exception thrown when an input for `β` is wrong.

"""
mutable struct ScatsGenWR_β <: Exception
    file::AbstractString
    ScatsGenWR_β(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_β) =
print(io, "\n\nScats.internal.ScatsGenWR_β:\nWrong input: β (\"", e.file, "\").\n")

"""
    ScatsGenWR_r <: Exception

Exception thrown when an input for `r` is wrong.

"""
mutable struct ScatsGenWR_r <: Exception
    file::AbstractString
    ScatsGenWR_r(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_r) =
print(io, "\n\nScats.internal.ScatsGenWR_r:\nWrong input: r (\"", e.file, "\").\n")

"""
    ScatsGenWR_A <: Exception

Exception thrown when an input for `A` is wrong.

"""
mutable struct ScatsGenWR_A <: Exception
    file::AbstractString
    ScatsGenWR_A(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_A) =
print(io, "\n\nScats.internal.ScatsGenWR_A:\nWrong input: A (\"", e.file, "\").\n")

"""
    ScatsGenWR_ν <: Exception

Exception thrown when an input for `ν` is wrong.

"""
mutable struct ScatsGenWR_ν <: Exception
    file::AbstractString
    ScatsGenWR_ν(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_ν) =
print(io, "\n\nScats.internal.ScatsGenWR_ν:\nWrong input: ν (\"", e.file, "\").\n")

"""
    ScatsGenWR_ϕ <: Exception

Exception thrown when an input for `ϕ` is wrong.

"""
mutable struct ScatsGenWR_ϕ <: Exception
    file::AbstractString
    ScatsGenWR_ϕ(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_ϕ) =
print(io, "\n\nScats.internal.ScatsGenWR_ϕ:\nWrong input: ϕ (\"", e.file, "\").\n")

"""
    ScatsGenWR_γ <: Exception

Exception thrown when an input for `γ` is wrong.

"""
mutable struct ScatsGenWR_γ <: Exception
    file::AbstractString
    ScatsGenWR_γ(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_γ) =
print(io, "\n\nScats.internal.ScatsGenWR_γ:\nWrong input: γ (\"", e.file, "\").\n")