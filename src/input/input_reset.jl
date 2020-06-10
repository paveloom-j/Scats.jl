# Этот файл содержит метод для возврата внутренних
# объектов к состоянию по умолчанию

"Метод для возврата внутренних объектов к состоянию по умолчанию"
function reset!(input::InputStruct)

    input.N = 0
    input.Δt = input.q = 0.0
    input.t = input.x = []

    nothing

end