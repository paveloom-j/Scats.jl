module TestInput

using Test
using SCATS: api, internal.input
using Printf

println("\033[1m\033[32mCHECKING\033[0m: input_test.jl")

# Создание экземпляра API
s = api()

# Путь к файлу input
input_path = "Файлы/input"

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

# Описание функции для порчи данных
@inline function break_a_line(ln::Int)
    (tmppath, tmpio) = mktemp()
    open(input_path) do io
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
    mv(tmppath, "input", force=true)
end

@testset "Считывание плохих входных данных" begin

    exceptions = [input.ScatsInputWR_N, input.ScatsInputWR_Δt, input.ScatsInputWR_q,
                  input.ScatsInputWR_t, input.ScatsInputWR_x]

    messages = ["\n\nscats.internal.ScatsInputWR_N:\nНе удалось считать значение размера выборки в файле \"input\".
Проверьте правильность введенных данных.\n",
"\n\nscats.internal.ScatsInputWR_Δt:\nНе удалось считать значение шага выборки в файле \"input\".
Проверьте правильность введенных данных.\n",
"\n\nscats.internal.ScatsInputWR_q:\nНе удалось считать значение уровня значимости в файле \"input\".
Проверьте правильность введенных данных.\n",
"\n\nscats.internal.ScatsInputWR_t:\nНе удалось считать значения массива времени в файле \"input\".
Проверьте правильность введенных данных.\n",
"\n\nscats.internal.ScatsInputWR_x:\nНе удалось считать значения массива значений в файле \"input\".
Проверьте правильность введенных данных.\n"]

    for i in 1:5

        n = 2 + (i - 1) * 3
        break_a_line(n)

        try
            s.read_input!("input")
        catch e
            @test e isa exceptions[i]
            @test sprint(showerror, e) == messages[i]
        end

    end

    rm("input")

end

@testset "Проверка статуса файла" begin

    try
        s.read_input!("Wrong file path!")
    catch e
        @test e isa input.ScatsInputNotAFile
        @test sprint(showerror, e) == "\n\nscats.internal.ScatsInputNotAFile:\nНе найден файл \"Wrong file path!\".\n"
    end

    (tmppath, tmpio) = mktemp()
    try
        s.read_input!(tmppath)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    println(tmpio, "1
2")

    try
        s.read_input!(tmppath)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    try
        input.skip(tmpio, tmppath)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    println(tmpio, "
3")

    try
        s.read_input!(tmppath)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    try
        input.skip(tmpio, tmppath)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    println(tmpio, "
4")

    try
        s.read_input!(tmppath)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

    try
        input.skip(tmpio, tmppath)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nscats.internal.ScatsInputEOF:\nВстречен неожиданный конец файла (\"", tmppath, "\").\n")
    end

end

s.read_input!(input_path)

@testset "Проверка записи в файл" begin

    contents = ["230", " 1.000000000000000E+00", " 1.000000000000000E-02",
                join([ @sprintf "% .15E" t for t in 0.0:229.0 ], "   "),
                join([ @sprintf "% .15E" t for t in 0.0:229.0 ], "   ") ]

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