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

    function VisualizeStruct()
        this = new()
        this.input = function(input_file::AbstractString, output_file::AbstractString) vis_input(input_file, output_file) end
        this
    end

end

include("vis_pre.jl")   # Настройка параметров графиков
include("vis_input.jl") # Метод для визуализации входных данных

end