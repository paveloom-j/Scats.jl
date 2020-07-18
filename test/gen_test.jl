# This file contains tests for the time series generator

# A module which contains the code to
# perform tests on .gen module from Scats
module TestGen

using Test                     # A package to perform tests
using Scats: api, internal.gen # API and .gen module from Scats
using Scats.internal.prec      # Precision module from Scats

# Print the header
println("\e[1;32mCHECKING\e[0m: gen_test.jl")

# Create an instance of the API
s = api()

# Test exceptions related to file status
@testset "Check file status" begin

    # Test when a wrong path has been specified
    try
        s.read_gen!("Wrong file path!")
    catch e
        @test e isa gen.ScatsGenNotAFile
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsGenNotAFile:\n",
        "The file is not found (\"Wrong file path!\").\n")
    end

    # Create a temporary file
    (tmppath, tmpio) = mktemp()

    # Test the end of file exception on an empty file
    try
        s.read_gen!(tmppath)
    catch e
        @test e isa gen.ScatsGenEOF
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsGenEOF:\n",
        "Unexpected end of file (\"", tmppath, "\").\n")
    end

    # Test the end of file exception on files with different number of lines
    for i in 1:28

        # Generate valid data on input lines
        if !(i in range(2, 29, step=3))
            println(tmpio, "Line #", i)
        elseif i == 2 || i == 17
            println(tmpio, IT(1))
        else
            println(tmpio, RT(1.0))
        end

        # Update the file immediately
        flush(tmpio)

        # Test the exception
        try
            s.read_gen!(tmppath)
        catch e
            @test e isa gen.ScatsGenEOF
            @test sprint(showerror, e) == string("\n\n",
            "Scats.internal.ScatsGenEOF:\n",
            "Unexpected end of file (\"", tmppath, "\").\n")
        end

    end

end

# Test different ways to read parameters
@testset "Read `good` parameters" begin

    # Create a temporary file
    file, _ = mktemp()

    # Write generator parameters
    s.gen.example(file)

    # Read the generator parameters
    s.read_gen!(file)

    # Test values
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

    # Reset values
    s.gen.reset!()

    # Read the generator parameters (another way)
    s.gen.read!(file)

    # Test values
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

    # Reset values
    s.gen.reset!()

    # Read the generator parameters (another way)
    s.gen(file)

    # Test values
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

# Test the creation of an example of generator parameters
@testset "Check creation of an example" begin

    # Create a temporary file
    file, _ = mktemp()

    # Write generator parameters
    s.gen.example(file)

    # Read the generator parameters
    s.read_gen!(file)

    # Test values
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

    # Create a temporary directory
    dir = mktempdir()

    # Test the exception being thrown when a directory has been passed
    try
        s.gen.example(dir)
    catch e
        @test e isa gen.ScatsGenIsADir
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsGenIsADir:\n",
        "Specified path is a directory (\"", e.file, "\").\n")
    end

    # Write generator parameters (another way)
    s.gen_example(file)

    # Read the generator parameters
    s.read_gen!(file)

    # Test values
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

    # Test the exception being thrown when a directory has been passed
    try
        s.gen_example(dir)
    catch e
        @test e isa gen.ScatsGenIsADir
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsGenIsADir:\n",
        "Specified path is a directory (\"", e.file, "\").\n")
    end

end

# Test all exceptions related to invalid input
@testset "Read `bad` parameters" begin

    # Specify a list of exceptions
    exceptions = [
        gen.ScatsGenWR_N, gen.ScatsGenWR_Δt, gen.ScatsGenWR_q,
        gen.ScatsGenWR_α, gen.ScatsGenWR_β, gen.ScatsGenWR_r,
        gen.ScatsGenWR_A, gen.ScatsGenWR_ν, gen.ScatsGenWR_ϕ,
        gen.ScatsGenWR_γ
    ]

    # Specify a list of expected messages
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
        "\n\nScats.internal.ScatsGenWR_γ:\nWrong input: γ (\"gen\").\n"
    ]

    # Create a temporary file to contain valid parameters
    good_file, _ = mktemp()

    # Write generator parameters
    s.gen.example(good_file)

    # Corrupt a file on a specific line
    @inline function break_a_line!(ln::Int)

        # Create a temporary file to contain invalid parameters
        (file, io) = mktemp()

        open(good_file) do good_io

            k = 0

            # Print lines of the `good` file into the `bad` file
            for line in eachline(good_io)

                k += 1

                # Corrupt a line
                if k == ln
                    line = "Hello there!\n"
                end

                # Print a line
                println(io, line)

            end

        end

        # Close the stream
        close(io)

        # Save the temporary file as `gen`
        cp(file, "gen", force=true)

    end

    # Test all cases of corrupted input
    for i in 1:10

        # Calculate the number of a line to corrupt
        n = 2 + (i - 1) * 3

        # Corrupt a specific line
        break_a_line!(n)

        # Test an exception
        try
            s.read_gen!("gen")
        catch e
            @test e isa exceptions[i]
            @test sprint(showerror, e) == messages[i]
        end

    end

    # Remove the `gen` file
    isfile("gen") && rm("gen")

end

# Test generation of time series
@testset "Check generation" begin

    # Create a temporary file
    file, _ = mktemp()

    # Write generator parameters
    s.gen.example(file)

    # Read the generator parameters
    s.read_gen!(file)

    # Generate time series
    s.gen!()

    # Test scalars
    @test s.input.N != 0
    @test s.input.Δt != 0
    @test s.input.q != 0

    # Test arrays
    @test s.input.t[1] == 0
    for t in s.input.t[2:s.input.N]
        @test t != 0
    end
    for x in s.input.x[1:s.input.N]
        @test x != 0
    end

end

# Test values resetting
@testset "Check resetting" begin

    # Create a temporary file
    file, _ = mktemp()

    # Write generator parameters
    s.gen.example(file)

    # Read the generator parameters
    s.gen(file)

    # Reset values
    s.gen.reset!()

    # Test values
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
