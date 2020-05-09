module TestGeneration

using Test
using SCATS: api, internal.gen

# Создание экземпляра
s = api()

# Путь к хорошему файлу с параметрами генератора
gen_path = "../examples/Файлы/gen"

@testset "Проверка статуса файла" begin

    try
        s.read_gen!("Wrong file path!")
    catch e
        @test e isa gen.ScatsGenNotAFile
    end

    try
        (tmppath, _) = mktemp()
        s.read_gen!(tmppath)
    catch e
        @test e isa gen.ScatsGenEOF
    end

end

@testset "Считывание хороших параметров" begin

    s.read_gen!("../examples/Файлы/gen")
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

# Описание функции для генерации
@inline function break_a_line(ln::Int)
    (tmppath, tmpio) = mktemp()
    open(gen_path) do io
        k = 0
        for line in eachline(io, keep=true)
            k += 1
            if k == ln
                line = "Hello there!\n"
            end
            write(tmpio, line)
        end
    end
    close(tmpio)
    mv(tmppath, "gen", force=true)
end

@testset "Считывание плохих параметров" begin

    exceptions = [gen.ScatsGenWR_N, gen.ScatsGenWR_Δt, gen.ScatsGenWR_q,
                  gen.ScatsGenWR_α, gen.ScatsGenWR_β, gen.ScatsGenWR_r,
                  gen.ScatsGenWR_A, gen.ScatsGenWR_ν, gen.ScatsGenWR_ϕ,
                  gen.ScatsGenWR_γ]

    for i in 1:10
        n = 2 + (i - 1) * 3
        break_a_line(n)
        try
            s.read_gen!("gen")
        catch e
            @test e isa exceptions[i]
        end
    end

    rm("gen")

end

end