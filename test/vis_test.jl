# Этот файл содержит тесты визуализации данных

module TestVis

using Test
using Scats: api, internal.vis
using Scats.internal.prec

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

@testset "Проверка создания графика (vis_input)" begin
    @test isfile("input.pdf")
    @test filesize("input.pdf") > 1000
end

rm("input.pdf")

# Вспомогательная функция для порчи данных
@inline function break_a_line!(ln::Int)
    k = 0
    open(tmppath2, "w") do tmpio2
        for line in eachline(tmppath)
            k += 1
            if k == ln
                line = "Hello there!"
            end
            println(tmpio2, line)
        end
    end
    cp(tmppath2, tmppath, force=true)
end

(tmppath, tmpio) = mktemp()
tmppath2, _ = mktemp()

@testset "Проверка исключений (vis_input)" begin

    try
        s.vis.input("Wrong file path!")
    catch e
        @test e isa vis.ScatsVisNotAFile
        @test sprint(showerror, e) == "\n\nscats.internal.ScatsVisNotAFile:\nНе найден файл \"Wrong file path!\".\n"
    end

    try
        s.vis.input(tmppath)
    catch e
        @test e isa vis.ScatsVisEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsVisEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    for i in 1:14

        if !(i in [2, 11, 14])
            println(tmpio, i, "-я строка")
        elseif i == 2
            println(tmpio, 1)
        else
            println(tmpio, RT(1.0))
        end

        flush(tmpio)

        try
            s.vis.input(tmppath)
        catch e
            @test e isa vis.ScatsVisEOF
            @test sprint(showerror, e) == string("\n\nscats.internal.ScatsVisEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
        end

    end

    exceptions = [vis.ScatsVisWR_x, vis.ScatsVisWR_t, vis.ScatsVisWR_N]
    errors = [string("\n\nscats.internal.ScatsVisWR_x:\nНе удалось считать значения массива значений в файле \"", tmppath, "\".
Проверьте правильность введенных данных.\n"),
              string("\n\nscats.internal.ScatsVisWR_t:\nНе удалось считать значения массива времени в файле \"", tmppath, "\".
Проверьте правильность введенных данных.\n"),
              string("\n\nscats.internal.ScatsVisWR_N:\nНе удалось считать значение размера выборки в файле \"", tmppath, "\".
Проверьте правильность введенных данных.\n")]

    for i in 1:3

        n = 14 - (i - 1) * 3 - (i == 3 ? 6 : 0)
        break_a_line!(n)

        try
            s.vis.input(tmppath)
        catch e
            @test e isa exceptions[i]
            @test sprint(showerror, e) == string(errors[i])
        end

    end

end

rm("input.pdf")

end