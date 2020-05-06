__precompile__()

# Этот файл содержит описание
# внешнего интерфейса модуля SCATS

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
`read_input!(this::api, file::AbstractString)`: считывание входных данных из файла.
`write_input!(this::api, file::AbstractString)`: запись входных данных в файл.
`reset!(this::api)`: возврат к состоянию по умолчанию.
"""
mutable struct api

    input::InputStruct
    read_input!::Function
    write_input!::Function
    reset!::Function

    function api()
        this = new()
        this.input = InputStruct()
        this.read_input! = function(file::AbstractString) this.input.read!(file) end
        this.write_input! = function(file::AbstractString) this.input.write!(file) end
        this.reset! = function() this.input.reset!() end
        this
    end

end

end