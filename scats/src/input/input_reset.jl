# Этот файл содержит метод для возврата внутренних
# объектов к состоянию по умолчанию

"Метод для возврата внутренних объектов к состоянию по умолчанию"
function reset!(input::InputStruct)

    input.N = 0
    input.Δt = 0
    input.q = 0
    input.t = []
    input.x = []

end