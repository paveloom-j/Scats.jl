# Этот файл содержит описание метода
# для генерации временного ряда

function gen!(gen::GenStruct, input::InputStruct)

    # Распаковка
    N = gen.N
    Δt = gen.Δt
    q = gen.q
    α = gen.α
    β = gen.β
    r = gen.r
    A = gen.A
    ν = gen.ν
    ϕ = gen.ϕ
    γ = gen.γ

    # Сохранение некоторых значений в input
    input.N = N
    input.Δt = Δt
    input.q = q

    # Вычисление стандартного отклонения
    σ = √(sum(A .* A) / (2 * γ))

    # Вычисление вспомогательной переменной
    N₋₁ = N - 1

    # Проверка размеров векторов
    if size(input.t, 1) != N
        input.t = Vector{RT}(undef, N)
    end
    if size(input.x, 1) != N
        input.x = Vector{RT}(undef, N)
    end

    "Вспомогательная функция для обвертки массива"
    @inline function Array(array)
        OffsetArray(array, 0:N₋₁)
    end

    # Обертывание массивов input
    ta = Array(input.t)
    xa = Array(input.x)

    # Генерация массива случайных чисел
    rng = MersenneTwister()
    rand = Array(randn(rng, RT, N))

    for k in 0:N₋₁

        t = Δt * k
        ta[k] = t

        c = α + β * t

        for l in 1:r

            c = c + A[l] * cos(2 * π * ν[l] * t - ϕ[l])

        end

        c = c + rand[k]

        xa[k] = c

    end

end