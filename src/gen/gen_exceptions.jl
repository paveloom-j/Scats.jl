# Этот файл содержит описания исключений для методов,
# которые взаимодействуют с генератором временного ряда

# Исключение, бросаемое, когда переданный путь
# не указывает на существующий файл
mutable struct ScatsGenNotAFile <: Exception
    file::AbstractString
    ScatsGenNotAFile(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenNotAFile) =
print(io, "\n\nScats.internal.ScatsGenNotAFile:\nНе найден файл \"", e.file, "\".\n")

# Исключение, бросаемое, когда переданный путь
# указывает на существующую директорию
mutable struct ScatsGenIsADir <: Exception
    file::AbstractString
    ScatsGenIsADir(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenIsADir) =
print(io, "\n\nScats.internal.ScatsGenIsADir:\nSpecified path is a directory (\"", e.file, "\").\n")

# Исключение, бросаемое, когда был
# Unexpected end of file
mutable struct ScatsGenEOF <: Exception
    file::AbstractString
    ScatsGenEOF(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenEOF) =
print(io, "\n\nScats.internal.ScatsGenEOF:\nUnexpected end of file (\"", e.file, "\").\n")

# Исключение, бросаемое, когда не удалось
# считать значение размера выборки
mutable struct ScatsGenWR_N <: Exception
    file::AbstractString
    ScatsGenWR_N(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_N) =
print(io, "\n\nScats.internal.ScatsGenWR_N:\nWrong input: N \"", e.file, "\".\n")

# Исключение, бросаемое, когда не удалось
# считать значение шага выборки
mutable struct ScatsGenWR_Δt <: Exception
    file::AbstractString
    ScatsGenWR_Δt(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_Δt) =
print(io, "\n\nScats.internal.ScatsGenWR_Δt:\nWrong input: Δt \"", e.file, "\".\n")

# Исключение, бросаемое, когда не удалось
# считать значение уровня значимости
mutable struct ScatsGenWR_q <: Exception
    file::AbstractString
    ScatsGenWR_q(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_q) =
print(io, "\n\nScats.internal.ScatsGenWR_q:\nWrong input: q \"", e.file, "\".\n")

# Исключение, бросаемое, когда не удалось
# считать значение параметра α линейного тренда
mutable struct ScatsGenWR_α <: Exception
    file::AbstractString
    ScatsGenWR_α(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_α) =
print(io, "\n\nScats.internal.ScatsGenWR_α:\nНе удалось считать значение параметра α линейного тренда в файле \"", e.file, "\".\n")

# Исключение, бросаемое, когда не удалось
# считать значение параметра Β линейного тренда
mutable struct ScatsGenWR_β <: Exception
    file::AbstractString
    ScatsGenWR_β(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_β) =
print(io, "\n\nScats.internal.ScatsGenWR_β:\nНе удалось считать значение параметра Β линейного тренда в файле \"", e.file, "\".\n")

# Исключение, бросаемое, когда не удалось
# считать значение числа гармонических компонент
mutable struct ScatsGenWR_r <: Exception
    file::AbstractString
    ScatsGenWR_r(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_r) =
print(io, "\n\nScats.internal.ScatsGenWR_r:\nНе удалось считать значение числа гармонических компонент в файле \"", e.file, "\".\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива амплитуд гармонических компонент
mutable struct ScatsGenWR_A <: Exception
    file::AbstractString
    ScatsGenWR_A(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_A) =
print(io, "\n\nScats.internal.ScatsGenWR_A:\nНе удалось считать значения массива амплитуд гармонических компонент в файле \"", e.file, "\".\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива частот гармонических компонент
mutable struct ScatsGenWR_ν <: Exception
    file::AbstractString
    ScatsGenWR_ν(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_ν) =
print(io, "\n\nScats.internal.ScatsGenWR_ν:\nНе удалось считать значения массив частот гармонических компонент в файле \"", e.file, "\".\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива фазовых сдвигов гармонических компонент
mutable struct ScatsGenWR_ϕ <: Exception
    file::AbstractString
    ScatsGenWR_ϕ(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_ϕ) =
print(io, "\n\nScats.internal.ScatsGenWR_ϕ:\nНе удалось считать значения массив частот гармонических компонент в файле \"", e.file, "\".\n")

# Исключение, бросаемое, когда не удалось
# считать значение отношения «сигнал к шуму»
mutable struct ScatsGenWR_γ <: Exception
    file::AbstractString
    ScatsGenWR_γ(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_γ) =
print(io, "\n\nScats.internal.ScatsGenWR_γ:\nWrong input: q \"", e.file, "\".\n")