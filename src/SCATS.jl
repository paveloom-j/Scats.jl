__precompile__()

# Этот файл содержит описание
# внешнего интерфейса модуля SCATS

baremodule SCATS

"""
Модуль, содержащий в себе полный набор объектов,\\
используемых во внутренних имплементациях.

Не предназначен для прямого использования.

Замечание: точности целых (`IP`) и вещественных (`RT`) чисел\\
могут быть изменены при необходимости в файле "scats/src/prec.jl"
"""
module internal
include("prec.jl")          # Точность входных данных
include("input/input.jl")   # Входные данные
include("result/result.jl") # Результат
include("gen/gen.jl")       # Генератор временного ряда
using .prec
using .input
using .result
using .gen
end

using .internal: InputStruct, ResultStruct, GenStruct

"""
API модуля scats.

# Используемые типы:
`input::InputStruct`: входные данные.
`gen::GenStruct`: генератор входных данных.
# Доступные методы:
`read_input!(this::api, file::AbstractString)`: считывание входных данных из файла.
`write_input!(this::api, file::AbstractString)`: запись входных данных в файл.
`gen!(this::api)`: генерация временного ряда.
`reset!(this::api)`: возврат к состоянию по умолчанию.
"""
mutable struct api

    input::InputStruct
    result::ResultStruct
    gen::GenStruct
    read_input!::Function
    read_gen!::Function
    write_input!::Function
    gen!::Function
    reset!::Function

    function api()

        this = new()
        this.input = InputStruct()
        this.result = ResultStruct()
        this.gen = GenStruct()
        this.read_input! = function(file::AbstractString) this.input.read!(file) end
        this.read_gen! = function(file::AbstractString) this.gen.read!(file) end
        this.write_input! = function(file::AbstractString) this.input.write!(file) end
        this.reset! = function() this.input.reset!(), this.result.reset!(), this.gen.reset!() end
        this.gen! = function() this.gen.gen!(this.gen, this.input) end
        this

    end

end

end