# This file contains tests for input type

module TestInput

using Test
using Scats: api, internal.input
using Scats.internal.prec
using Formatting

println("\033[1m\033[32mCHECKING\033[0m: input_test.jl")

# Create an instance of API
s = api()

# Path to the file with `good` input data
input_path = joinpath(dirname(dirname(Base.find_package("Scats"))), "test", "files", "input")
if Sys.iswindows()
    input_path = replace(input_path, "\\" => "/")
end

@testset "Reading `good` data" begin

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

@testset "Checking creation of an example" begin

    tmppath, _ = mktemp()

    s.input.example(tmppath)
    s.read_input!(tmppath)

    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    tmpdir = mktempdir()

    try
        s.input.example(tmpdir)
    catch e
        @test e isa input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsInputIsADir:\nSpecified path is a directory (\"", e.file, "\").\n")
    end

    isdir(tmpdir) && rm(tmpdir)

    tmppath, _ = mktemp()

    s.input_example(tmppath)
    s.read_input!(tmppath)

    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    tmpdir = mktempdir()

    try
        s.input_example(tmpdir)
    catch e
        @test e isa input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsInputIsADir:\nSpecified path is a directory (\"", e.file, "\").\n")
    end

    isdir(tmpdir) && rm(tmpdir)

end

@testset "Checking file status" begin

    try
        s.read_input!("Wrong file path!")
    catch e
        @test e isa input.ScatsInputNotAFile
        @test sprint(showerror, e) == "\n\nScats.internal.ScatsInputNotAFile:\nThe file is not found (\"Wrong file path!\").\n"
    end

    (tmppath, tmpio) = mktemp()

    try
        s.read_input!(tmppath)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsInputEOF:\nUnexpected end of file (\"", tmppath, "\").\n")
    end

    for i in 1:13

        if !(i in range(2, 11, step=3))
            println(tmpio, "Line ", i)
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
            @test sprint(showerror, e) == string("\n\nScats.internal.ScatsInputEOF:\nUnexpected end of file (\"", tmppath, "\").\n")
        end

    end

end

# Corrupt a file on a specific line
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

@testset "Reading `bad` data" begin

    exceptions = [input.ScatsInputWR_x, input.ScatsInputWR_t, input.ScatsInputWR_q, input.ScatsInputWR_Δt, input.ScatsInputWR_N]
    errors = ["\n\nScats.internal.ScatsInputWR_x:\nWrong input: x (\"input\").\n",
              "\n\nScats.internal.ScatsInputWR_t:\nWrong input: t (\"input\").\n",
              "\n\nScats.internal.ScatsInputWR_q:\nWrong input: q (\"input\").\n",
              "\n\nScats.internal.ScatsInputWR_Δt:\nWrong input: Δt (\"input\").\n",
              "\n\nScats.internal.ScatsInputWR_N:\nWrong input: N (\"input\").\n"]

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

s.read_input!(input_path)

@testset "Checking writing" begin

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

@testset "Checking resetting" begin

    s.input.reset!()
    @test s.input.N == 0
    @test s.input.Δt == 0.0
    @test s.input.q == 0.0
    @test s.input.t == []
    @test s.input.x == []

end

end