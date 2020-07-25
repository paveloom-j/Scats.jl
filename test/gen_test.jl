# This file contains tests for the time series generator

# A module which contains the code to
# perform tests on .Gen module from Scats
module TestGen

using Scats.Internal.Prec      # Precision module from Scats
using Scats: Internal.Gen, API # API and .Gen module from Scats
using Test                     # A package to perform tests

# Load the general utilities
include("utilities.jl")

# Print the header
println("\e[1;32mRUNNING\e[0m: gen_test.jl")

"""
Read generator parameters from a file
"""
macro gen_read(file)
    return esc(:(s.Gen.read!($file)))
end

"""
Generate an example of a file containing generator parameters
"""
macro gen_example(file)
    return esc(:(s.Gen.example($file)))
end

"""
Reset the values of the generator parameters
"""
macro gen_reset()
    return esc(:(s.Gen.reset!()))
end

"""
Test the values of generator parameters
"""
macro test_values()
    return esc(quote
        @test s.Gen.N == 230
        @test s.Gen.Δt == 1
        @test s.Gen.q == 0.01
        @test s.Gen.α == 0.1
        @test s.Gen.β == 0.05
        @test s.Gen.r == 1
        @test s.Gen.A == [1]
        @test s.Gen.ν == [0.1]
        @test s.Gen.ϕ == [0]
        @test s.Gen.γ == 0.5
    end)
end

"""
Create a temporary file, write exemplary
generator parameters in it and read them
"""
macro read_example_params()
    return esc(quote
        @file
        @gen_example file
        @gen_read file
    end)
end

"""
Test the end of file exception on a file
"""
macro test_eof_exception()
    return esc(quote
        try
            @gen_read file
        catch e
            @test e isa Gen.ScatsGenEOF
            @test sprint(showerror, e) == retrieve_messages(
                Gen.ScatsGenEOF, file,
            )
        end
    end)
end

@construct_exceptions "Gen.ScatsGen"

# Test exceptions related to file status
@testset "Check file status" begin

    @instantiate

    # Test when a wrong path has been specified
    try
        @gen_read "Wrong file path!"
    catch e
        @test e isa Gen.ScatsGenNotAFile
        @test sprint(showerror, e) == retrieve_messages(
            Gen.ScatsGenNotAFile, "Wrong file path!"
        )
    end

    @file
    @test_eof_exception

    # Test the end of file exception on files with different number of lines
    for i in 1:28

        # Generate valid data on input lines
        if !(i in range(2, 29, step = 3))
            println(io, "Line #", i)
        elseif i == 2 || i == 17
            println(io, IT(1))
        else
            println(io, RT(1.0))
        end

        # Update the file immediately
        flush(io)

        @test_eof_exception

    end

end

# Test different ways to read parameters
@testset "Read `good` parameters" begin

    @instantiate

    @read_example_params

    @test_values
    @gen_reset

    # Read the generator parameters (another way)
    s.Gen.read!(file)

    @test_values
    @gen_reset

    # Read the generator parameters (another way)
    s.Gen(file)

    @test_values

end

# println(a)

# Test the creation of an example of generator parameters
@testset "Check creation of an example" begin

    @instantiate
    @read_example_params
    @test_values

    # Create a temporary directory
    dir = mktempdir()

    # Test the exception being thrown when a directory has been passed
    try
        @gen_example dir
    catch e
        @test e isa Gen.ScatsGenIsADir
        @test sprint(showerror, e) == retrieve_messages(
            Gen.ScatsGenIsADir, dir,
        )
    end

    # Write generator parameters (another way)
    s.gen_example(file)

    @gen_read file
    @test_values

    # Test the exception being thrown when a directory has been passed (another way)
    try
        s.gen_example(dir)
    catch e
        @test e isa Gen.ScatsGenIsADir
        @test sprint(showerror, e) == retrieve_messages(
            Gen.ScatsGenIsADir, dir,
        )
    end

end

# Test all exceptions related to invalid input
@testset "Read `bad` parameters" begin

    @instantiate

    # Construct an ordered list of exceptions
    exceptions = construct_exceptions(
        "WR", "N", "Δt", "q", "α", "β", "r", "A", "ν", "ϕ", "γ",
    )

    # Get an ordered list of expected messages
    messages = retrieve_messages(exceptions, "gen")

    # Create a temporary file to contain valid parameters
    good_file, _ = mktemp()

    @gen_example good_file

    # Corrupt a file on a specific line
    @inline function break_a_line!(ln::Int)

        @file

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
        cp(file, "gen", force = true)

    end

    # Test all cases of corrupted input
    for i in 1:10

        # Calculate the number of a line to corrupt
        n = 2 + (i - 1) * 3

        # Corrupt a specific line
        break_a_line!(n)

        # Test an exception
        try
            @gen_read "gen"
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

    @instantiate
    @read_example_params

    # Generate time series
    s.gen!()

    # Test scalars
    @test s.Input.N != 0
    @test s.Input.Δt != 0
    @test s.Input.q != 0

    # Test arrays
    @test s.Input.t[1] == 0
    for t in s.Input.t[2:s.Input.N]
        @test t != 0
    end
    for x in s.Input.x[1:s.Input.N]
        @test x != 0
    end

end

# Test values resetting
@testset "Check resetting" begin

    @instantiate
    @read_example_params

    @gen_reset

    # Test values
    @test s.Gen.N == 0
    @test s.Gen.Δt == 0
    @test s.Gen.q == 0
    @test s.Gen.α == 0
    @test s.Gen.β == 0
    @test s.Gen.r == 0
    @test s.Gen.A == []
    @test s.Gen.ν == []
    @test s.Gen.ϕ == []
    @test s.Gen.γ == 0

end

end
