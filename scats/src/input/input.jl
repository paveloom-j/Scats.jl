# Этот файл описывает класс для
# взаимодействия с входными данными

include("../prec.jl") # Точность

"""
Тип, описывающий входные данные.

# Данные
`N::IT`: размер выборки.
`Δt::RT`: шаг выборки.
`q::RT`: уровень значимости.
`t::RT`: массив времени.
`x::RT`: массив значений.

# Методы
`read!(this::InputStruct, file::AbstractString)`
"""
mutable struct InputStruct

    N::IT
    Δt::RT
    q::RT
    t::Array{RT}
    x::Array{RT}
    read!::Function
    function InputStruct()
        this = new(0, 0, 0, [], [])
        this.read! = function(file::AbstractString) read!(this, file) end
        this
    end

end

include("input_exceptions.jl") # Исключения
include("input_read.jl") # Метод для считывания входных данных