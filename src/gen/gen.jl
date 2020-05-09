# Этот файл содержит определение интерфейса
# для взаимодействия с генератором данных

module gen
export GenStruct, gen!

# Случайные числа
using Random

# Массивы с нестандартной индексацией
using OffsetArrays

# Точность данных
using ..prec

# Входные данные
using ..input

"Интерфейс генератора временного ряда"
mutable struct GenStruct

    N::IT # Размер выборки

    Δt::RT # Шаг выборки
    q::RT  # Уровень значимости

    # Параметры линейного тренда
    α::RT
    β::RT

    r::IT # Число гармонических компонент

    A::Vector{RT} # Массив амплитуд
    ν::Vector{RT} # Массив частот
    ϕ::Vector{RT} # Массив фазовых сдвигов

    γ::RT # Отношение «сигнал к шуму»

    read!::Function # Метод для считывания
                    # параметров генератора временного ряда

    gen!::Function   # Метод для вызова генератора временного ряда

    reset!::Function # Метод для сброса к значениям по умолчанию

    function GenStruct()
        this = new(0, 0.0, 0.0, 0.0, 0.0, 0.0, [], [], [], 0.0)
        this.read! = function(file::AbstractString) read!(this, file) end
        this.gen! = function(gen::GenStruct, input::InputStruct) gen!(this, input) end
        this.reset! = function() reset!(this) end
        this
    end

    function (gen::GenStruct)(file::AbstractString)
        gen.read!(file)
    end

end

include("gen_exceptions.jl") # Исключения
include("gen_read.jl") # Метод для считывания
                       # параметров генератора временного ряда
include("gen_gen.jl") # Метод для генерации временного ряда
include("gen_reset.jl") # Метод сброса к значениям по умолчанию

end