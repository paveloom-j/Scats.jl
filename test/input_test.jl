# This file contains tests for input type

# A module which contains the code to
# perform tests on .input module from Scats
module TestInput

using Test                       # A package to perform tests
using Scats: api, internal.input # API and .input module from Scats
using Scats.internal.prec        # Precision module from Scats
using Formatting                 # Formatted strings

# Print the header
println("\e[1;32mCHECKING\e[0m: input_test.jl")

# Create an instance of API
s = api()

# Test exceptions related to file status
@testset "Check file status" begin

    # Test when a wrong path has been specified
    try
        s.read_input!("Wrong file path!")
    catch e
        @test e isa input.ScatsInputNotAFile
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsInputNotAFile:\n",
        "The file is not found (\"Wrong file path!\").\n")
    end

    # Create a temporary file
    (path, io) = mktemp()

    # Test the end of file exception on an empty file
    try
        s.read_input!(path)
    catch e
        @test e isa input.ScatsInputEOF
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsInputEOF:\n",
        "Unexpected end of file (\"", path, "\").\n")
    end

    # Test the end of file exception on files with different number of lines
    for i in 1:13

        # Generate valid data on input lines
        if !(i in range(2, 11, step=3))
            println(io, "Line ", i)
        elseif i == 2
            println(io, 1)
        else
            println(io, RT(1.0))
        end

        # Update the file immediately
        flush(io)

        # Test the exception
        try
            s.read_input!(path)
        catch e
            @test e isa input.ScatsInputEOF
            @test sprint(showerror, e) == string("\n\n",
            "Scats.internal.ScatsInputEOF:\n",
            "Unexpected end of file (\"", path, "\").\n")
        end

    end

end

# Test different ways to read input data
@testset "Read `good` data" begin

    # Create a temporary file
    file, _ = mktemp()

    # Write input data
    s.input_example(file)

    # Read the input data
    s.read_input!(file)

    # Test values
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    # Reset values
    s.input.reset!()

    # Read the input data (another way)
    s.input.read!(file)

    # Test values
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    # Reset values
    s.input.reset!()

    # Read the input data (another way)
    s.input(file)

    # Test values
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

end

# Test the creation of an example of input data
@testset "Check creation of an example" begin

    # Create a temporary file
    file, _ = mktemp()

    # Write input data
    s.input.example(file)

    # Read input data
    s.read_input!(file)

    # Test values
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    # Create a temporary directory
    dir = mktempdir()

    # Test the exception being thrown when a directory has been passed
    try
        s.input.example(dir)
    catch e
        @test e isa input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsInputIsADir:\n",
        "Specified path is a directory (\"", e.file, "\").\n")
    end

    # Write input data
    s.input_example(file)

    # Read the input data
    s.read_input!(file)

    # Test values
    @test s.input.N == 230
    @test s.input.Δt == 1.0
    @test s.input.q == 0.01
    @test s.input.t == [ t for t in 0.0:229.0 ]
    @test s.input.x == [ x for x in 0.0:229.0 ]

    # Test the exception being thrown when a directory has been passed
    try
        s.input_example(dir)
    catch e
        @test e isa input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsInputIsADir:\n",
        "Specified path is a directory (\"", e.file, "\").\n")
    end

end

# Test all exceptions related to invalid input
@testset "Read `bad` data" begin

    # Specify a list of exceptions
    exceptions = [
        input.ScatsInputWR_x, input.ScatsInputWR_t,
        input.ScatsInputWR_q, input.ScatsInputWR_Δt,
        input.ScatsInputWR_N
    ]

    # Specify a list of expected messages
    messages = [
        "\n\nScats.internal.ScatsInputWR_x:\nWrong input: x (\"input\").\n",
        "\n\nScats.internal.ScatsInputWR_t:\nWrong input: t (\"input\").\n",
        "\n\nScats.internal.ScatsInputWR_q:\nWrong input: q (\"input\").\n",
        "\n\nScats.internal.ScatsInputWR_Δt:\nWrong input: Δt (\"input\").\n",
        "\n\nScats.internal.ScatsInputWR_N:\nWrong input: N (\"input\").\n"
    ]

    # Create a temporary file to contain valid parameters
    good_file, _ = mktemp()

    # Write generator parameters
    s.input.example(good_file)

    # Corrupt a file on a specific line
    @inline function break_a_line!(ln::Int)

        # Create a temporary file to contain invalid parameters
        (file, io) = mktemp()

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
        cp(file, "input", force=true)

    end

    # Test all cases of corrupted input
    for i in 1:5

        # Calculate the number of a line to corrupt
        n = 14 - (i - 1) * 3

        # Corrupt a specific line
        break_a_line!(n)

        # Test an exception
        try
            s.read_input!("input")
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

    # Specify expected values to be writed
    contents = [
        "230", " 1.000000000000000E+00", " 1.000000000000000E-02",
        join( [ sprintf1(prec.RF, s) for s in 0.0:229.0 ], " "^3 ),
        join( [ sprintf1(prec.RF, s) for s in 0.0:229.0 ], " "^3 )
    ]

    # Create a temporary file to contain input data (from example)
    file, _ = mktemp()

    # Write input data
    s.input.example(file)

    # Read the input data
    s.input(file)

    # Create another temporary file to contain input data (written)
    file, _ = mktemp()

    # Write input data
    s.write_input(file)

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

    # Create a temporary file
    file, _ = mktemp()

    # Write input data
    s.input.example(file)

    # Read input data
    s.input(file)

    # Reset values
    s.input.reset!()

    # Test values
    @test s.input.N == 0
    @test s.input.Δt == 0.0
    @test s.input.q == 0.0
    @test s.input.t == []
    @test s.input.x == []

end

end
