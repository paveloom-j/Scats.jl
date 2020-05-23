# Этот файл содержит описание интерфейса для
# вызова процедур визуализации данных

module vis
export VisualizeStruct

# Графики
using PyPlot

# Точность данных
using ..prec

mutable struct VisualizeStruct

    input::Function

    input_default_path::String

    function VisualizeStruct()
        this = new()
        this.input_default_path = "input.pdf"
        this.input = function(input_file::AbstractString, output_file::AbstractString = this.input_default_path) vis_input(input_file, output_file) end
        this
    end

end

include("vis_pre.jl")        # Настройка параметров графиков
include("vis_input.jl")      # Метод для визуализации входных данных
include("vis_exceptions.jl") # Исключения

end