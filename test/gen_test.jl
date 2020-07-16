# This file contains tests for the time series generator

module TestGen

using Test
using Scats: api, internal.gen
using Scats.internal.prec

println("\e[1;32mCHECKING\e[0m: gen_test.jl")

# Create an instance of the API
s = api()

@testset "Check file status" begin

    try
        s.read_gen!("Wrong file path!")
    catch e
        @test e isa gen.ScatsGenNotAFile
        @test sprint(showerror, e) == "\n\nScats.internal.ScatsGenNotAFile:\nThe file is not found (\"Wrong file path!\").\n"
    end

    (tmppath, tmpio) = mktemp()

    try
        s.read_gen!(tmppath)
    catch e
        @test e isa gen.ScatsGenEOF
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsGenEOF:\nUnexpected end of file (\"", tmppath, "\").\n")
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
            @test sprint(showerror, e) == string("\n\nScats.internal.ScatsGenEOF:\nUnexpected end of file (\"", tmppath, "\").\n")
        end

    end

end

@testset "Read `good` parameters" begin

    file, _ = mktemp()
    s.gen.example(file)

    s.read_gen!(file)
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

    s.gen.read!(file)
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

    s.gen(file)
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

@testset "Check creation of an example" begin

    file, _ = mktemp()

    s.gen.example(file)
    s.read_gen!(file)

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

    dir = mktempdir()

    try
        s.gen.example(dir)
    catch e
        @test e isa gen.ScatsGenIsADir
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsGenIsADir:\nSpecified path is a directory (\"", e.file, "\").\n")
    end

    isdir(dir) && rm(dir)

    file, _ = mktemp()

    s.gen_example(file)
    s.read_gen!(file)

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

    dir = mktempdir()

    try
        s.gen_example(dir)
    catch e
        @test e isa gen.ScatsGenIsADir
        @test sprint(showerror, e) == string("\n\nScats.internal.ScatsGenIsADir:\nSpecified path is a directory (\"", e.file, "\").\n")
    end

    isdir(dir) && rm(dir)

end

@testset "Read `bad` parameters" begin

    exceptions = [gen.ScatsGenWR_N, gen.ScatsGenWR_Δt, gen.ScatsGenWR_q,
                  gen.ScatsGenWR_α, gen.ScatsGenWR_β, gen.ScatsGenWR_r,
                  gen.ScatsGenWR_A, gen.ScatsGenWR_ν, gen.ScatsGenWR_ϕ,
                  gen.ScatsGenWR_γ]

    messages = [
"\n\nScats.internal.ScatsGenWR_N:\nWrong input: N (\"gen\").\n",
"\n\nScats.internal.ScatsGenWR_Δt:\nWrong input: Δt (\"gen\").\n",
"\n\nScats.internal.ScatsGenWR_q:\nWrong input: q (\"gen\").\n",
"\n\nScats.internal.ScatsGenWR_α:\nWrong input: α (\"gen\").\n",
"\n\nScats.internal.ScatsGenWR_β:\nWrong input: β (\"gen\").\n",
"\n\nScats.internal.ScatsGenWR_r:\nWrong input: r (\"gen\").\n",
"\n\nScats.internal.ScatsGenWR_A:\nWrong input: A (\"gen\").\n",
"\n\nScats.internal.ScatsGenWR_ν:\nWrong input: ν (\"gen\").\n",
"\n\nScats.internal.ScatsGenWR_ϕ:\nWrong input: ϕ (\"gen\").\n",
"\n\nScats.internal.ScatsGenWR_γ:\nWrong input: γ (\"gen\").\n"]

    good_file, _ = mktemp()
    s.gen.example(good_file)

    # Corrupt a file on a specific line
    @inline function break_a_line!(ln::Int)
        (file, io) = mktemp()
        open(good_file) do good_io
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
        cp(file, "gen", force=true)
    end

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

@testset "Check generation" begin

    file, _ = mktemp()
    s.gen.example(file)
    s.read_gen!(file)

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

@testset "Check resetting" begin

    file, _ = mktemp()
    s.gen.example(file)
    s.gen(file)

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