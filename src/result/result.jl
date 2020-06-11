# Этот файл содержит описание интерфейса
# для взаимодействия с результатом

module result
export ResultStruct

# Точность данных
using ..prec

"oof"
mutable struct ResultStruct

    Δt::RT # Sample step

    t::Vector{RT} # Time array
    x::Vector{RT} # Values array

    q::RT # Significance level
    threshold::RT # Порог обнаружения сигнала

    X_FFT_ABS::Vector{RT} # Модуль преобразованных значений

    ν::Vector{RT} # Массив частот периодограммы
    D::Vector{RT} # Values array периодограммы

    c::Vector{RT}  # Values array коррелограммы
    cw::Vector{RT} # Values array взвешенной коррелограммы

    Dw::Vector{RT} # Values array сглаженной периодограммы

    reset!::Function # Метод для сброса к значениям по умолчанию

    function ResultStruct()
        this = new(0.0, [], [], 0.0, 0.0, [], [], [], [], [])
        this.reset! = function() reset!(this) end
        this
    end

end

include("result_reset.jl") # Метод для сброса к значениям по умолчанию

end