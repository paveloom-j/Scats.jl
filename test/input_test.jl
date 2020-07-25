# This file contains tests for input type

# A module which contains the code to
# perform tests on .Input module from Scats
module TestInput

using Formatting                 # Formatted strings
using Scats.Internal.Prec        # Precision module from Scats
using Scats: Internal.Input, API # API and .Input module from Scats
using Test                       # A package to perform tests

# Load the general utilities
include("utilities.jl")

# Print the header
println("\e[1;32mRUNNING\e[0m: input_test.jl")

"""
Read input data from a file
"""
macro input_read(file)
    return esc(:(s.Input.read!($file)))
end

"""
Generate an example of a file containing input data
"""
macro input_example(file)
    return esc(:(s.Input.example($file)))
end

"""
Reset the values of the input data
"""
macro input_reset()
    return esc(:(s.Input.reset!()))
end

"""
Test the values of input data
"""
macro test_values()
    return esc(quote
        @test s.Input.N == 230
        @test s.Input.Δt == 1.0
        @test s.Input.q == 0.01
        @test s.Input.t == [ t for t in 0.0:229.0 ]
        @test s.Input.x == [ x for x in 0.0:229.0 ]
    end)
end

"""
Create a temporary file, write exemplary
generator parameters in it and read them
"""
macro read_example_data()
    return esc(quote
        @file
        @input_example file
        @input_read file
    end)
end

"""
Test the end of file exception on an empty file
"""
macro test_eof_exception()
    return esc(quote
        try
            @input_read file
        catch e
            @test e isa Input.ScatsInputEOF
            @test sprint(showerror, e) == retrieve_messages(
                Input.ScatsInputEOF, file
            )
        end
    end)
end

@construct_exceptions "Input.ScatsInput"

# Test exceptions related to file status
@testset "Check file status" begin

    @instantiate

    # Test when a wrong path has been specified
    try
        @input_read "Wrong file path!"
    catch e
        @test e isa Input.ScatsInputNotAFile
        @test sprint(showerror, e) == retrieve_messages(
            Input.ScatsInputNotAFile, "Wrong file path!"
        )
    end

    @file
    @test_eof_exception

    # Test the end of file exception on files with different number of lines
    for i in 1:13

        # Generate valid data on input lines
        if !(i in range(2, 11, step = 3))
            println(io, "Line ", i)
        elseif i == 2
            println(io, 1)
        else
            println(io, RT(1.0))
        end

        # Update the file immediately
        flush(io)

        @test_eof_exception

    end

end

# Test different ways to read input data
@testset "Read `good` data" begin

    @instantiate

    @read_example_data

    @test_values
    @input_reset

    # Read the input data (another way)
    s.Input.read!(file)

    @test_values
    @input_reset

    # Read the input data (another way)
    s.Input(file)

    @test_values

end

# Test the creation of an example of input data
@testset "Check creation of an example" begin

    @instantiate
    @read_example_data
    @test_values

    # Create a temporary directory
    dir = mktempdir()

    # Test the exception being thrown when a directory has been passed
    try
        @input_example dir
    catch e
        @test e isa Input.ScatsInputIsADir
        @test sprint(showerror, e) == retrieve_messages(
            Input.ScatsInputIsADir, dir,
        )
    end

    # Write input data (another way)
    s.input_example(file)

    @input_read file
    @test_values

    # Test the exception being thrown when a directory has been passed
    try
        s.input_example(dir)
    catch e
        @test e isa Input.ScatsInputIsADir
        @test sprint(showerror, e) == retrieve_messages(
            Input.ScatsInputIsADir, dir,
        )
    end

end

# Test all exceptions related to invalid input
@testset "Read `bad` data" begin

    @instantiate

    # Construct an ordered list of exceptions
    exceptions = construct_exceptions(
        "WR", "N", "Δt", "q", "t", "x"
    )

    # Get an ordered list of expected messages
    messages = retrieve_messages(exceptions, "input")

    # Create a temporary file to contain valid parameters
    good_file, _ = mktemp()

    @input_example good_file

    # Corrupt a file on a specific line
    @inline function break_a_line!(ln::Int)

        @file

        open(good_file, "r") do good_io

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

        # Save the temporary file as `input`
        cp(file, "input", force = true)

    end

    # Test all cases of corrupted input
    for i in 1:5

        # Calculate the number of a line to corrupt
        n = 2 + (i - 1) * 3

        # Corrupt a specific line
        break_a_line!(n)

        # Test an exception
        try
            @input_read "input"
        catch e
            @test e isa exceptions[i]
            @test sprint(showerror, e) == string(messages[i])
        end

    end

    # Remove the `input` file
    isfile("input") && rm("input")

end

# Test writing input data to a file
@testset "Check writing" begin

    @instantiate

    # Specify expected values to be writed
    contents = [
        "230", " 1.000000000000000E+00", " 1.000000000000000E-02",
        join([ sprintf1(Prec.RF, s) for s in 0.0:229.0 ], " "^3),
        join([ sprintf1(Prec.RF, s) for s in 0.0:229.0 ], " "^3)
    ]

    # Create a temporary file to contain input data (from example)
    @file

    @input_example file
    @input_read file

    # Create another temporary file to contain input data (written)
    @file

    # Write input data
    s.write_input(file)

    # Read lines from the written file
    lines = readlines(file)

    # Test the values
    for i in 1:5
        n = 2 + (i - 1) * 3
        @test lines[n] == contents[i]
    end

    # Write input data (another way)
    s.Input.write(file)

    # Read lines from the written file
    lines = readlines(file)

    # Test the values
    for i in 1:5
        n = 2 + (i - 1) * 3
        @test lines[n] == contents[i]
    end

end

# Test values resetting
@testset "Check resetting" begin

    @instantiate
    @read_example_data

    @input_reset

    # Test values
    @test s.Input.N == 0
    @test s.Input.Δt == 0.0
    @test s.Input.q == 0.0
    @test s.Input.t == []
    @test s.Input.x == []

end

end
