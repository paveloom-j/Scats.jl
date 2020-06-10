# Этот файл содержит тесты для генератора временного ряда

module TestGen

using Test
using Scats: api, internal.gen
using Scats.internal.prec

println("\033[1m\033[32mCHECKING\033[0m: gen_test.jl")

# Создание экземпляра API
s = api()

# Путь к хорошему файлу с параметрами генератора
gen_path = joinpath(dirname(dirname(Base.find_package("Scats"))), "test", "files", "gen")
if Sys.iswindows()
    gen_path = replace(gen_path, "\\" => "/")
end

@testset "Проверка статуса файла" begin

    try
        s.read_gen!("Wrong file path!")
    catch e
        @test e isa gen.ScatsGenNotAFile
        @test sprint(showerror, e) == "\n\nScats.internal.ScatsGenNotAFile:\nНе найден файл \"Wrong file path!\".\n"
    end

    (tmppath, tmpio) = mktemp()

    try
        s.read_gen!(tmppath)
    catch e
        @test e isa gen.ScatsGenEOF
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsGenEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    for i in 1:28

        if !(i in range(2, 29, step=3))
            println(tmpio, i, "-я строка")
        elseif i == 2 || i == 17
            println(tmpio, IT(1))
        else
            println(tmpio, RT(1.0))
        end

        flush(tmpio)

        try
            s.read_gen!(tmppath)
        catch e
            @test e isa gen.ScatsGenEOF
            @test sprint(showerror, e) == string("\n\nScats.internal.ScatsGenEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
        end

    end

end

@testset "Считывание хороших параметров" begin

    s.read_gen!(gen_path)
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

    s.gen.reset!()

    s.gen.read!(gen_path)
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

    s.gen.reset!()

    s.gen(gen_path)
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

@testset "Проверка генерации примера" begin

    tmppath, _ = mktemp()

    s.gen.example(tmppath)
    s.read_gen!(tmppath)

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

    tmpdir = mktempdir()

    try
        s.gen.example(tmpdir)
    catch e
        @test e isa gen.ScatsGenIsADir
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsGenIsADir:\nУказанный путь является директорией (\"", e.file, "\").\n")
    end

    isdir(tmpdir) && rm(tmpdir)

    tmppath, _ = mktemp()

    s.gen_example(tmppath)
    s.read_gen!(tmppath)

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

    tmpdir = mktempdir()

    try
        s.gen_example(tmpdir)
    catch e
        @test e isa gen.ScatsGenIsADir
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsGenIsADir:\nУказанный путь является директорией (\"", e.file, "\").\n")
    end

    isdir(tmpdir) && rm(tmpdir)

end

# Описание функции для порчи данных
@inline function break_a_line!(ln::Int)
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
    cp(tmppath, "gen", force=true)
end

@testset "Считывание плохих параметров" begin

    exceptions = [gen.ScatsGenWR_N, gen.ScatsGenWR_Δt, gen.ScatsGenWR_q,
                  gen.ScatsGenWR_α, gen.ScatsGenWR_β, gen.ScatsGenWR_r,
                  gen.ScatsGenWR_A, gen.ScatsGenWR_ν, gen.ScatsGenWR_ϕ,
                  gen.ScatsGenWR_γ]

    messages = ["\n\nScats.internal.ScatsGenWR_N:\nНе удалось считать значение размера выборки в файле \"gen\".
Проверьте правильность введенных данных.\n",
"\n\nScats.internal.ScatsGenWR_Δt:\nНе удалось считать значение шага выборки в файле \"gen\".
Проверьте правильность введенных данных.\n",
"\n\nScats.internal.ScatsGenWR_q:\nНе удалось считать значение уровня значимости в файле \"gen\".
Проверьте правильность введенных данных.\n",
"\n\nScats.internal.ScatsGenWR_α:\nНе удалось считать значение параметра α линейного тренда в файле \"gen\".
Проверьте правильность введенных данных.\n",
"\n\nScats.internal.ScatsGenWR_β:\nНе удалось считать значение параметра Β линейного тренда в файле \"gen\".
Проверьте правильность введенных данных.\n",
"\n\nScats.internal.ScatsGenWR_r:\nНе удалось считать значение числа гармонических компонент в файле \"gen\".
Проверьте правильность введенных данных.\n",
"\n\nScats.internal.ScatsGenWR_A:\nНе удалось считать значения массива амплитуд гармонических компонент в файле \"gen\".
Проверьте правильность введенных данных.\n",
"\n\nScats.internal.ScatsGenWR_ν:\nНе удалось считать значения массив частот гармонических компонент в файле \"gen\".
Проверьте правильность введенных данных.\n",
"\n\nScats.internal.ScatsGenWR_ϕ:\nНе удалось считать значения массив частот гармонических компонент в файле \"gen\".
Проверьте правильность введенных данных.\n",
"\n\nScats.internal.ScatsGenWR_γ:\nНе удалось считать значение уровня значимости в файле \"gen\".
Проверьте правильность введенных данных.\n"]

    for i in 1:10

        n = 2 + (i - 1) * 3
        break_a_line!(n)

        try
            s.read_gen!("gen")
        catch e
            @test e isa exceptions[i]
            @test sprint(showerror, e) == messages[i]
        end

    end

    isfile("gen") && rm("gen")

end

s.read_gen!(gen_path)

@testset "Проверка генерации" begin

    s.gen!()

    @test s.input.N != 0
    @test s.input.Δt != 0
    @test s.input.q != 0

    @test s.input.t[1] == 0
    for t in s.input.t[2:s.input.N]
        @test t != 0
    end
    for x in s.input.x[1:s.input.N]
        @test x != 0
    end

end

@testset "Проверка сброса" begin

    s.gen.reset!()
    @test s.gen.N == 0
    @test s.gen.Δt == 0.0
    @test s.gen.q == 0.0
    @test s.gen.α == 0.0
    @test s.gen.β == 0.0
    @test s.gen.r == 0.0
    @test s.gen.A == []
    @test s.gen.ν == []
    @test s.gen.ϕ == []
    @test s.gen.γ == 0.0

end

end