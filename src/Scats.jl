__precompile__()

# Этот файл содержит описание
# внешнего интерфейса модуля Scats

baremodule Scats

"""
Модуль, содержащий в себе полный набор объектов,\\
используемых во внутренних имплементациях.

Не предназначен для прямого использования.

Замечание: точности целых (`IP`) и вещественных (`RT`) чисел\\
могут быть изменены при необходимости в файле "scats/src/prec.jl"
"""
module internal
include("prec.jl")          # Точность входных данных
include("extras/extras.jl") # Вспомогательные функции
include("input/input.jl")   # Входные данные
include("result/result.jl") # Результат
include("gen/gen.jl")       # Генератор временного ряда
include("vis/vis.jl")       # Визуализация
using .prec
using .input
using .result
using .gen
using .vis
using .extras
end

using .internal: InputStruct, ResultStruct, GenStruct, VisualizeStruct, _precompile
import Base.!, Base.!==, Base.println

# Функция для генерации скрипта для прекомпиляции этого пакета или пакета PyPlot
precompile = _precompile

"""
API модуля scats.

# Используемые типы:
`input::InputStruct`: входные данные.
`gen::GenStruct`: генератор входных данных.
`vis::VisualizeStruct`: интерфейс для визуализации данных.
# Доступные методы:
`read_input!(this::api, file::AbstractString)`: считывание входных данных из файла.
`write_input!(this::api, file::AbstractString)`: запись входных данных в файл.
`gen!(this::api)`: генерация временного ряда.
`reset!(this::api)`: возврат к состоянию по умолчанию.
"""
mutable struct api

    input::InputStruct
    read_input!::Function
    write_input::Function
    input_example::Function

    gen::GenStruct
    read_gen!::Function
    gen!::Function
    gen_example::Function

    result::ResultStruct
    vis::VisualizeStruct
    vis_input::Function

    reset!::Function

    function api()

        this = new()

        this.input = InputStruct()
        this.read_input! = function(file::AbstractString) this.input.read!(file) end
        this.write_input = function(file::AbstractString) this.input.write(file) end
        this.input_example = function(file::AbstractString) this.input.example(file) end

        this.gen = GenStruct()
        this.read_gen! = function(file::AbstractString) this.gen.read!(file) end
        this.gen! = function() this.gen.gen!(this.gen, this.input) end
        this.gen_example = function(file::AbstractString) this.gen.example(file) end

        this.result = ResultStruct()
        this.vis = VisualizeStruct()
        this.vis_input = function(input_file::AbstractString, output_file::AbstractString=this.vis.input_default_path)
                            this.vis.input(input_file, output_file)
                         end

        this.reset! = function() this.input.reset!(), this.result.reset!(), this.gen.reset!() end

        this

    end

end

end