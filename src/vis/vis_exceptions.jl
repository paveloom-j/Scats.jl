# Этот файл содержит описания исключений для методов,
# которые связаны с визуализацией данных

# Исключение, бросаемое, когда переданный путь
# не указывает на существующий файл
mutable struct ScatsVisNotAFile <: Exception
    file::AbstractString
    ScatsVisNotAFile(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsVisNotAFile) =
print(io, "\n\nScats.internal.ScatsVisNotAFile:\nНе найден файл \"", e.file, "\".\n")

# Исключение, бросаемое, когда был
# встречен неожиданный конец файла
mutable struct ScatsVisEOF <: Exception
    file::AbstractString
    ScatsVisEOF(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsVisEOF) =
print(io, "\n\nScats.internal.ScatsVisEOF:\nВстречен неожиданный конец файла (\"", e.file, "\").\n")

# Исключение, бросаемое, когда не удалось
# считать значение размера выборки
mutable struct ScatsVisWR_N <: Exception
    file::AbstractString
    ScatsVisWR_N(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsVisWR_N) =
print(io, "\n\nScats.internal.ScatsVisWR_N:\nНе удалось считать значение размера выборки в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива времени
mutable struct ScatsVisWR_t <: Exception
    file::AbstractString
    ScatsVisWR_t(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsVisWR_t) =
print(io, "\n\nScats.internal.ScatsVisWR_t:\nНе удалось считать значения массива времени в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")

# Исключение, бросаемое, когда не удалось
# считать значения массива значений
mutable struct ScatsVisWR_x <: Exception
    file::AbstractString
    ScatsVisWR_x(file::AbstractString) = new(file)

end

Base.showerror(io::IO, e::ScatsVisWR_x) =
print(io, "\n\nScats.internal.ScatsVisWR_x:\nНе удалось считать значения массива значений в файле \"", e.file, "\".
Проверьте правильность введенных данных.\n")