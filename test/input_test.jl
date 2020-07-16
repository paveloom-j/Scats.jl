# This file contains tests for input type

module TestInput

using Test
using Scats: api, internal.input
using Scats.internal.prec
using Formatting

println("\e[1;32mCHECKING\e[0m: input_test.jl")

# Create an instance of API
s = api()

@testset "Read `good` data" begin

    file, _ = mktemp()
    s.input_example(file)

    s.read_input!(file)
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    s.input.reset!()

    s.input.read!(file)
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    s.input.reset!()

    s.input(file)
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

end

@testset "Check creation of an example" begin

    file, _ = mktemp()
    s.input.example(file)
    s.read_input!(file)

    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    dir = mktempdir()

    try
        s.input.example(dir)
    catch e
        @test e isa input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsInputIsADir:\nSpecified path is a directory (\"", e.file, "\").\n")
    end

    isdir(dir) && rm(dir)

    file, _ = mktemp()

    s.input_example(file)
    s.read_input!(file)

    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    dir = mktempdir()

    try
        s.input_example(dir)
    catch e
        @test e isa input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsInputIsADir:\nSpecified path is a directory (\"", e.file, "\").\n")
    end

    isdir(dir) && rm(dir)

end

@testset "Check file status" begin

    try
        s.read_input!("Wrong file path!")
    catch e
        @test e isa input.ScatsInputNotAFile
        @test sprint(showerror, e) == "\n\nScats.internal.ScatsInputNotAFile:\nThe file is not found (\"Wrong file path!\").\n"
    end

    (path, io) = mktemp()

    try
        s.read_input!(path)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsInputEOF:\nUnexpected end of file (\"", path, "\").\n")
    end

    for i in 1:13

        if !(i in range(2, 11, step=3))
            println(io, "Line ", i)
        elseif i == 2
            println(io, 1)
        else
            println(io, RT(1.0))
        end

        flush(io)

        try
            s.read_input!(path)
        catch e
            @test e isa input.ScatsInputEOF
            @test sprint(showerror, e) == string("\n\nScats.internal.ScatsInputEOF:\nUnexpected end of file (\"", path, "\").\n")
        end

    end

end

@testset "Read `bad` data" begin

    exceptions = [input.ScatsInputWR_x, input.ScatsInputWR_t, input.ScatsInputWR_q, input.ScatsInputWR_Δt, input.ScatsInputWR_N]
    errors = ["\n\nScats.internal.ScatsInputWR_x:\nWrong input: x (\"input\").\n",
              "\n\nScats.internal.ScatsInputWR_t:\nWrong input: t (\"input\").\n",
              "\n\nScats.internal.ScatsInputWR_q:\nWrong input: q (\"input\").\n",
              "\n\nScats.internal.ScatsInputWR_Δt:\nWrong input: Δt (\"input\").\n",
              "\n\nScats.internal.ScatsInputWR_N:\nWrong input: N (\"input\").\n"]

    good_file, _ = mktemp()
    s.input.example(good_file)

    # Corrupt a file on a specific line
    @inline function break_a_line!(ln::Int)
        (file, io) = mktemp()
        open(good_file, "r") do good_io
            k = 0
            for line in eachline(good_io)
                k += 1
                if k == ln
                    line = "Hello there!\n"
                end
                println(io, line)
            end
        end
        close(io)
        cp(file, "input", force=true)
    end

    for i in 1:5

        n = 14 - (i - 1) * 3
        break_a_line!(n)

        try
            s.read_input!("input")
        catch e
            @test e isa exceptions[i]
            @test sprint(showerror, e) == string(errors[i])
        end

    end

    isfile("input") && rm("input")

end

@testset "Check writing" begin

    contents = ["230", " 1.000000000000000E+00", " 1.000000000000000E-02",
                join( [ sprintf1(prec.RF, s) for s in 0.0:229.0 ], " "^3 ),
                join( [ sprintf1(prec.RF, s) for s in 0.0:229.0 ], " "^3 ) ]

    file2, _ = mktemp()
    s.input.example(file2)
    s.input(file2)

    (file, io) = mktemp()
    s.write_input(file)

    lines = readlines(io)
    for i in 1:5
        n = 2 + (i - 1) * 3
        @test lines[n] == contents[i]
    end

end

@testset "Check resetting" begin

    file, _ = mktemp()
    s.input.example(file)
    s.input(file)

    s.input.reset!()
    @test s.input.N == 0
    @test s.input.Δt == 0.0
    @test s.input.q == 0.0
    @test s.input.t == []
    @test s.input.x == []

end

end