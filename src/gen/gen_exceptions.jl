# Этот файл содержит описания исключений для методов,
# которые взаимодействуют с генератором временного ряда

# Исключение, бросаемое, когда переданный путь
# не указывает на существующий файл
mutable struct ScatsGenNotAFile <: Exception
    file::AbstractString
    ScatsGenNotAFile(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenNotAFile) =
print(io, "\n\nscats.internal.ScatsGenNotAFile:\nНе найден файл \"", e.file, "\".\n")

# Исключение, бросаемое, когда файл
# не был открыт для считывания
mutable struct ScatsGenNotOpenToRead <: Exception
    file::AbstractString
    ScatsGenNotOpenToRead(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenNotOpenToRead) =
print(io, "\n\nscats.internal.ScatsGenNotOpenToRead:\nНе удалось открыть файл \"", e.file, "\" для считывания.\n")

# Исключение, бросаемое, когда был
# встречен неожиданный конец файла
mutable struct ScatsGenEOF <: Exception
    file::AbstractString
    ScatsGenEOF(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenEOF) =
print(io, "\n\nscats.internal.ScatsGenEOF:\nВстречен неожиданный конец файла (\"", e.file, "\").\n")

# Исключение, бросаемое, когда не удалось
# считать значение размера выборки
mutable struct ScatsGenWR_N <: Exception
    file::AbstractString
    ScatsGenWR_N(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_N) =
print(io, "\n\nscats.internal.ScatsGenWR_N:\nНе удалось считать значение размера выборки в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значение шага выборки
mutable struct ScatsGenWR_Δt <: Exception
    file::AbstractString
    ScatsGenWR_Δt(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_Δt) =
print(io, "\n\nscats.internal.ScatsGenWR_Δt:\nНе удалось считать значение шага выборки в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значение уровня значимости
mutable struct ScatsGenWR_q <: Exception
    file::AbstractString
    ScatsGenWR_q(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_q) =
print(io, "\n\nscats.internal.ScatsGenWR_q:\nНе удалось считать значение уровня значимости в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значение параметра α линейного тренда
mutable struct ScatsGenWR_α <: Exception
    file::AbstractString
    ScatsGenWR_α(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_α) =
print(io, "\n\nscats.internal.ScatsGenWR_α:\nНе удалось считать значение параметра α линейного тренда в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значение параметра Β линейного тренда
mutable struct ScatsGenWR_Β <: Exception
    file::AbstractString
    ScatsGenWR_Β(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_Β) =
print(io, "\n\nscats.internal.ScatsGenWR_Β:\nНе удалось считать значение параметра Β линейного тренда в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значение числа гармонических компонент
mutable struct ScatsGenWR_r <: Exception
    file::AbstractString
    ScatsGenWR_r(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_r) =
print(io, "\n\nscats.internal.ScatsGenWR_r:\nНе удалось считать значение числа гармонических компонент в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива амплитуд гармонических компонент
mutable struct ScatsGenWR_A <: Exception
    file::AbstractString
    ScatsGenWR_A(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_A) =
print(io, "\n\nscats.internal.ScatsGenWR_A:\nНе удалось считать значения массива амплитуд гармонических компонент в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива частот гармонических компонент
mutable struct ScatsGenWR_ν <: Exception
    file::AbstractString
    ScatsGenWR_ν(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_ν) =
print(io, "\n\nscats.internal.ScatsGenWR_ν:\nНе удалось считать значения массив частот гармонических компонент в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива фазовых сдвигов гармонических компонент
mutable struct ScatsGenWR_ϕ <: Exception
    file::AbstractString
    ScatsGenWR_ϕ(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsGenWR_ϕ) =
print(io, "\n\nscats.internal.ScatsGenWR_ϕ:\nНе удалось считать значения массив частот гармонических компонент в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значение отношения «сигнал к шуму»
mutable struct StatsGenWR_γ <: Exception
    file::AbstractString
    StatsGenWR_γ(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::StatsGenWR_γ) =
print(io, "\n\nscats.internal.StatsGenWR_γ:\nНе удалось считать значение уровня значимости в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")