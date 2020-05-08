# Этот файл содержит метод для сброса параметров
# генератора временного ряда к значениям по умолчанию

function reset!(gen::GenStruct)

    gen.N = gen.r = 0
    gen.Δt = gen.q = gen.α = gen.β = gen.γ = 0.0
    gen.A = gen.ν = gen.ϕ = []

end