# Этот файл содержит описание интерфейса
# для взаимодействия с результатом

module result
export ResultStruct

# Точность данных
using ..prec

mutable struct ResultStruct

    Δt::RT # Шаг выборки

    t::Vector{RT} # Массив времени
    x::Vector{RT} # Массив значений

    q::RT # Уровень значимости
    threshold::RT # Порог обнаружения сигнала

    X_FFT_ABS::Vector{RT} # Модуль преобразованных значений

    ν::Vector{RT} # Массив частот периодограммы
    D::Vector{RT} # Массив значений периодограммы

    c::Vector{RT}  # Массив значений коррелограммы
    cw::Vector{RT} # Массив значений взвешенной коррелограммы

    Dw::Vector{RT} # Массив значений сглаженной периодограммы

    reset!::Function # Метод для сброса к значениям по умолчанию

    function ResultStruct()
        this = new(0.0, [], [], 0.0, 0.0, [], [], [], [], [])
        this.reset! = function() reset!(this) end
        this
    end

end

include("result_reset.jl") # Метод для сброса к значениям по умолчанию

end