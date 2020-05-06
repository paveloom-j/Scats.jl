__precompile__()

baremodule scats

"""
Модуль, содержащий в себе полный набор объектов,\\
используемых во внутренней имплементации.

Не предназначен для прямого использования.

Замечание: точности целых (`IP`) и вещественных (`RT`) чисел\\
могут быть изменены при необходимости в файле "scats/src/prec.jl"
"""
module internal
include("input/input.jl")
end

using .internal: InputStruct, read!

"""
API модуля scats.

# Используемые типы:
`input::InputStruct`: входные данные.
# Доступные методы:
`read_input!(this::InputStruct, file::AbstractString)`: метод для считывания входных данных.
"""
mutable struct api

    input::InputStruct
    read_input!::Function

    function api()
        this = new()
        this.input = InputStruct()
        this.read_input! = function(file::AbstractString) read!(this.input, file) end
        this
    end

end

end