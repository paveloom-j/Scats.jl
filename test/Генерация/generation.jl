module TestGeneration

using Test
using SCATS

s = SCATS.api()

@testset "Считывание хороших параметров" begin

    s.read_gen!("Генерация/Файлы/gen_good")
    @test s.gen.N == 230
    @test s.gen.Δt == 1.0
    @test s.gen.q == 0.01
    @test s.gen.α == 0.1
    @test s.gen.β == 0.05
    @test s.gen.r == 1
    @test s.gen.A == [1.0]
    @test s.gen.ν == [0.1]
    @test s.gen.ϕ == [0.0]
    @test s.gen.γ == 0.50

end

end