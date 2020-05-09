module TestResult

using Test
using Scats: api, internal.result
using Scats.internal.prec
using Random

println("\033[1m\033[32mCHECKING\033[0m: result_test.jl")

# Создание экземпляра API
s = api()

@testset "Проверка сброса" begin

    rng = MersenneTwister()
    s.result.Δt = s.result.q = s.result.threshold = rand(rng, RT)
    s.result.t = s.result.x = s.result.X_FFT_ABS = rand(rng, RT, 20)
    s.result.ν = s.result.D = s.result.c = s.result.cw = s.result.Dw = rand(rng, RT, 20)

    s.result.reset!()
    @test s.result.Δt == 0.0
    @test s.result.q == 0.0
    @test s.result.threshold == 0.0
    @test s.result.t == []
    @test s.result.x == []
    @test s.result.X_FFT_ABS == []
    @test s.result.ν == []
    @test s.result.D == []
    @test s.result.c == []
    @test s.result.cw == []
    @test s.result.Dw == []

end

end