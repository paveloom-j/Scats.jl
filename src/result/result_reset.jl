# Этот файл содержит определение метода
# сброса результата к значениям по умолчанию

"Метод для сброса результата к значениям по умолчанию"
function reset!(result::ResultStruct)

    result.Δt = result.q = result.threshold = 0.0
    result.t = result.x = result.X_FFT_ABS = []
    result.ν = result.D = result.c = result.cw = result.Dw = []

    nothing

end