# Этот файл содержит тесты визуализации данных

module TestVis

using Test
using Scats: api, internal.vis
using Scats.internal.prec

println("\033[1m\033[32mCHECKING\033[0m: vis_test.jl")

# Путь к файлу input
input_path = "files/input"

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

    isfile("input.pdf") && rm("input.pdf")
end

@testset "Проверка статуса файла (vis_input)" begin

    try
        s.vis.input("Wrong file path!")
    catch e
        @test e isa vis.ScatsVisNotAFile
        @test sprint(showerror, e) == "\n\nScats.internal.ScatsVisNotAFile:\nНе найден файл \"Wrong file path!\".\n"
    end

    (tmppath, tmpio) = mktemp()

    try
        s.vis.input(tmppath)
    catch e
        @test e isa vis.ScatsVisEOF
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsVisEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    for i in 1:13

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
            @test sprint(showerror, e) == string("\n\nScats.internal.ScatsVisEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
        end

    end

    isfile("input.pdf") && rm("input.pdf")

end

# Вспомогательная функция для порчи данных
@inline function break_a_line!(ln::Int)
    (tmppath, tmpio) = mktemp()
    open(input_path) do io
        k = 0
        for line in eachline(io)
            k += 1
            if k == ln
                line = "Hello there!\n"
            end
            println(tmpio, line)
        end
    end
    close(tmpio)
    cp(tmppath, "input", force=true)
end

@testset "Проверка считывания плохих данных (vis_input)" begin

    exceptions = [vis.ScatsVisWR_x, vis.ScatsVisWR_t, vis.ScatsVisWR_N]
    errors = [string("\n\nScats.internal.ScatsVisWR_x:\nНе удалось считать значения массива значений в файле \"input\".
Проверьте правильность введенных данных.\n"),
              string("\n\nScats.internal.ScatsVisWR_t:\nНе удалось считать значения массива времени в файле \"input\".
Проверьте правильность введенных данных.\n"),
              string("\n\nScats.internal.ScatsVisWR_N:\nНе удалось считать значение размера выборки в файле \"input\".
Проверьте правильность введенных данных.\n")]

    for i in 1:3

        n = 14 - (i - 1) * 3 - (i == 3 ? 6 : 0)
        break_a_line!(n)

        try
            s.vis.input("input")
        catch e
            @test e isa exceptions[i]
            @test sprint(showerror, e) == string(errors[i])
        end

    end

    isfile("input") && rm("input")

end

end