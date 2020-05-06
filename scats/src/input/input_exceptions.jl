# Этот файл содержит описания исключений для методов,
# которые взаимодействуют с входными данными

# Исключение, бросаемое, когда переданный путь
# не указывает на существующий файл
mutable struct ScatsInputNotAFile <: Exception
    file::AbstractString
    ScatsInputNotAFile(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputNotAFile) =
print(io, "\n\nscats.internal.ScatsInputNotAFile:\nНе найден файл \"", e.file, "\".\n")

# Исключение, бросаемое, когда файл
# не был открыт для считывания
mutable struct ScatsInputNotOpenToRead <: Exception
    file::AbstractString
    ScatsInputNotAFile(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputNotOpenToRead) =
print(io, "\n\nscats.internal.ScatsInputNotOpenToRead:\nНе удалось открыть файл \"", e.file, "\" для считывания.\n")

# Исключение, бросаемое, когда был
# встречен неожиданный конец файла
mutable struct ScatsInputEOF <: Exception
    file::AbstractString
    ScatsInputEOF(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputEOF) =
print(io, "\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", e.file, "\").\n")

# Исключение, бросаемое, когда не удалось
# считать значение размера выборки
mutable struct ScatsInputWR_N <: Exception
    file::AbstractString
    ScatsInputWR_N(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_N) =
print(io, "\n\nscats.internal.ScatsInputWR_N:\nНе удалось считать значение размера выборки в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значение шага выборки
mutable struct ScatsInputWR_Δt <: Exception
    file::AbstractString
    ScatsInputWR_Δt(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_Δt) =
print(io, "\n\nscats.internal.ScatsInputWR_Δt:\nНе удалось считать значение шага выборки в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значение уровня значимости
mutable struct ScatsInputWR_q <: Exception
    file::AbstractString
    ScatsInputWR_q(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_q) =
print(io, "\n\nscats.internal.ScatsInputWR_q:\nНе удалось считать значение уровня значимости в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива времени
mutable struct ScatsInputWR_t <: Exception
    file::AbstractString
    ScatsInputWR_t(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_t) =
print(io, "\n\nscats.internal.ScatsInputWR_t:\nНе удалось считать значения массива времени в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива значений
mutable struct ScatsInputWR_x <: Exception
    file::AbstractString
    ScatsInputWR_x(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsInputWR_x) =
print(io, "\n\nscats.internal.ScatsInputWR_x:\nНе удалось считать значения массива значений в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")