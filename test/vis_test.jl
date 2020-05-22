# Этот файл содержит тесты визуализации данных

module TestVis

using Test
using Scats: api
using Scats.internal.vis

println("\033[1m\033[32mCHECKING\033[0m: vis_test.jl")

# Создание экземпляра API
s = api()

# Считывание параметров генератора временного ряда
s.read_gen!("files/gen")

# Генерация входных данных
s.gen!()

# Создание временного файла
tmppath, _ = mktemp()

# Запись временного ряда в файл
s.write_input(tmppath)

# Выполнение визуализации входных данных
s.vis.input(tmppath)

@testset "Проверка создания графика" begin
    @test isfile("input.pdf")
    @test filesize("input.pdf") > 1000
end

@testset "Проверка статуса файла" begin

    try
        s.vis.input("Wrong file path!")
    catch e
        @test e isa vis.ScatsVisNotAFile
        @test sprint(showerror, e) == "\n\nscats.internal.ScatsVisNotAFile:\nНе найден файл \"Wrong file path!\".\n"
    end

    (tmppath, tmpio) = mktemp()

    try
        s.vis.input(tmppath)
    catch e
        @test e isa vis.ScatsVisEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsVisEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    # for i in 1:8
    # println(tmpio, i)

    #     try
    #         s.vis.input(tmppath)
    #     catch e
    #         @test e isa vis.ScatsVisEOF
    #         @test sprint(showerror, e) == string("\n\nscats.internal.ScatsVisEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    #     end

    #     try
    #         vis.skip(tmpio, tmppath)
    #     catch e
    #         @test e isa vis.ScatsVisEOF
    #         @test sprint(showerror, e) == string("\n\nscats.internal.ScatsVisEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    #     end

    # end

end

rm("input.pdf")

end