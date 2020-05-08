# Этот файл описывает класс для
# взаимодействия с входными данными

module input
export InputStruct

# Массивы с нестандартной индексацией
using OffsetArrays

# Точность данных
using ..prec

"""
Тип, описывающий входные данные.

# Данные
`N::IT`: размер выборки.
`Δt::RT`: шаг выборки.
`q::RT`: уровень значимости.
`t::RT`: массив времени.
`x::RT`: массив значений.

# Методы
`read!(this::InputStruct, file::AbstractString)`: считывание входных данных из файла.
`write(this::InputStruct, file::AbstractString)`: запись входных данных в файл.
`deallocate(this::InputStruct)`: освобождение памяти из-под входных данных.
"""
mutable struct InputStruct

    N::IT
    Δt::RT
    q::RT
    t::Vector{RT}
    x::Vector{RT}
    read!::Function
    write::Function
    reset!::Function

    function InputStruct()
        this = new(0, 0, 0, [], [])
        this.read! = function(file::AbstractString) read!(this, file) end
        this.write = function(file::AbstractString) write(this, file) end
        this.reset! = function() reset!(this) end
        this
    end

    function (input::InputStruct)(file::AbstractString)
        input.read!(file)
    end

end

include("input_exceptions.jl") # Исключения
include("input_read.jl")       # Метод для считывания входных данных
include("input_write.jl")      # Метод для записи результата в файл
include("input_reset.jl")      # Метод для возврата внутренних
                               # объектов к состоянию по умолчанию

end