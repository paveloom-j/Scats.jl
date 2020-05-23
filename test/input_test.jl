# Этот файл содержит тесты для входных данных

module TestInput

using Test
using Scats: api, internal.input
using Scats.internal.prec
using Formatting

println("\033[1m\033[32mCHECKING\033[0m: input_test.jl")

# Создание экземпляра API
s = api()

# Путь к файлу input
input_path = "files/input"

@testset "Считывание хороших входных данных" begin

    s.read_input!(input_path)
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    s.input.reset!()

    s.input.read!(input_path)
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    s.input.reset!()

    s.input(input_path)
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

end

@testset "Проверка генерации примера" begin

    tmppath, _ = mktemp()

    s.input.example(tmppath)
    s.read_input!(tmppath)

    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    mkdir("tmp")

    try
        s.input.example("tmp")
    catch e
        @test e isa input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputIsADir:\nУказанный путь является директорией (\"tmp\").\n")
    end

    rm("tmp")

    tmppath, _ = mktemp()

    s.input_example(tmppath)
    s.read_input!(tmppath)

    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    mkdir("tmp")

    try
        s.input_example("tmp")
    catch e
        @test e isa input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputIsADir:\nУказанный путь является директорией (\"tmp\").\n")
    end

    rm("tmp")

end

# Вспомогательная функция для порчи данных
@inline function break_a_line!(ln::Int)
    tmppath2, _ = mktemp()
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

@testset "Проверка исключений" begin

    try
        s.read_input!("Wrong file path!")
    catch e
        @test e isa input.ScatsInputNotAFile
        @test sprint(showerror, e) == "\n\nscats.internal.ScatsInputNotAFile:\nНе найден файл \"Wrong file path!\".\n"
    end

    try
        s.read_input!(tmppath)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    for i in 1:13

        if !(i in [2, 5, 8, 11])
            println(tmpio, i, "-я строка")
        elseif i == 2
            println(tmpio, 1)
        else
            println(tmpio, RT(1.0))
        end

        flush(tmpio)

        try
            s.read_input!(tmppath)
        catch e
            @test e isa input.ScatsInputEOF
            @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
        end

    end

    println(tmpio, "Hello there!")
    flush(tmpio)

    try
        s.read_input!(tmppath)
    catch e
        @test e isa input.ScatsInputWR_x
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputWR_x:\nНе удалось считать значения массива значений в файле \"", tmppath, "\".
Проверьте правильность введенных данных.\n")
    end

    exceptions = [input.ScatsInputWR_t, input.ScatsInputWR_q, input.ScatsInputWR_Δt, input.ScatsInputWR_N]
    errors = [string("\n\nscats.internal.ScatsInputWR_t:\nНе удалось считать значения массива времени в файле \"", tmppath, "\".
Проверьте правильность введенных данных.\n"),
              string("\n\nscats.internal.ScatsInputWR_q:\nНе удалось считать значение уровня значимости в файле \"", tmppath, "\".
Проверьте правильность введенных данных.\n"),
              string("\n\nscats.internal.ScatsInputWR_Δt:\nНе удалось считать значение шага выборки в файле \"", tmppath, "\".
Проверьте правильность введенных данных.\n"),
              string("\n\nscats.internal.ScatsInputWR_N:\nНе удалось считать значение размера выборки в файле \"", tmppath, "\".
Проверьте правильность введенных данных.\n")]

    for i in 1:4

        n = 11 - (i - 1) * 3
        break_a_line!(n)

        try
            s.read_input!(tmppath)
        catch e
            @test e isa exceptions[i]
            @test sprint(showerror, e) == string(errors[i])
        end

    end

end

s.read_input!(input_path)

@testset "Проверка записи в файл" begin

    contents = ["230", " 1.000000000000000E+00", " 1.000000000000000E-02",
                join( [ sprintf1(prec.RF, s) for s in 0.0:229.0 ], " "^3 ),
                join( [ sprintf1(prec.RF, s) for s in 0.0:229.0 ], " "^3 ) ]

    (tmppath, tmpio) = mktemp()
    s.write_input(tmppath)
    lines = readlines(tmpio)
    for i in 1:5
        n = 2 + (i - 1) * 3
        @test lines[n] == contents[i]
    end

end

@testset "Проверка сброса" begin

    s.input.reset!()
    @test s.input.N == 0
    @test s.input.Δt == 0.0
    @test s.input.q == 0.0
    @test s.input.t == []
    @test s.input.x == []

end

end