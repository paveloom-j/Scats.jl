# This file contains tests for input type

# A module which contains the code to
# perform tests on .Input module from Scats
module TestInput

using Test                       # A package to perform tests
using Scats: api, internal.Input # API and .Input module from Scats
using Scats.internal.Prec        # Precision module from Scats
using Formatting                 # Formatted strings

# Print the header
println("\e[1;32mRUNNING\e[0m: input_test.jl")

# Create an instance of API
s = api()

# Test exceptions related to file status
@testset "Check file status" begin

    # Test when a wrong path has been specified
    try
        s.read_input!("Wrong file path!")
    catch e
        @test e isa Input.ScatsInputNotAFile
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
        @test e isa Input.ScatsInputEOF
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
            @test e isa Input.ScatsInputEOF
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
    @test s.Input.N == 230
    @test s.Input.Δt == 1.0
    @test s.Input.q == 0.01
    @test s.Input.t == [ t for t in 0.0:229.0 ]
    @test s.Input.x == [ x for x in 0.0:229.0 ]

    # Reset values
    s.Input.reset!()

    # Read the input data (another way)
    s.Input.read!(file)

    # Test values
    @test s.Input.N == 230
    @test s.Input.Δt == 1.0
    @test s.Input.q == 0.01
    @test s.Input.t == [ t for t in 0.0:229.0 ]
    @test s.Input.x == [ x for x in 0.0:229.0 ]

    # Reset values
    s.Input.reset!()

    # Read the input data (another way)
    s.Input(file)

    # Test values
    @test s.Input.N == 230
    @test s.Input.Δt == 1.0
    @test s.Input.q == 0.01
    @test s.Input.t == [ t for t in 0.0:229.0 ]
    @test s.Input.x == [ x for x in 0.0:229.0 ]

end

# Test the creation of an example of input data
@testset "Check creation of an example" begin

    # Create a temporary file
    file, _ = mktemp()

    # Write input data
    s.Input.example(file)

    # Read input data
    s.read_input!(file)

    # Test values
    @test s.Input.N == 230
    @test s.Input.Δt == 1.0
    @test s.Input.q == 0.01
    @test s.Input.t == [ t for t in 0.0:229.0 ]
    @test s.Input.x == [ x for x in 0.0:229.0 ]

    # Create a temporary directory
    dir = mktempdir()

    # Test the exception being thrown when a directory has been passed
    try
        s.Input.example(dir)
    catch e
        @test e isa Input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsInputIsADir:\n",
        "Specified path is a directory (\"", e.file, "\").\n")
    end

    # Write input data
    s.input_example(file)

    # Read the input data
    s.read_input!(file)

    # Test values
    @test s.Input.N == 230
    @test s.Input.Δt == 1.0
    @test s.Input.q == 0.01
    @test s.Input.t == [ t for t in 0.0:229.0 ]
    @test s.Input.x == [ x for x in 0.0:229.0 ]

    # Test the exception being thrown when a directory has been passed
    try
        s.input_example(dir)
    catch e
        @test e isa Input.ScatsInputIsADir
        @test sprint(showerror, e) == string("\n\n",
        "Scats.internal.ScatsInputIsADir:\n",
        "Specified path is a directory (\"", e.file, "\").\n")
    end

end

# Test all exceptions related to invalid input
@testset "Read `bad` data" begin

    # Specify a list of exceptions
    exceptions = [
        Input.ScatsInputWR_x, Input.ScatsInputWR_t,
        Input.ScatsInputWR_q, Input.ScatsInputWR_Δt,
        Input.ScatsInputWR_N
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
    s.Input.example(good_file)

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
        join( [ sprintf1(Prec.RF, s) for s in 0.0:229.0 ], " "^3 ),
        join( [ sprintf1(Prec.RF, s) for s in 0.0:229.0 ], " "^3 )
    ]

    # Create a temporary file to contain input data (from example)
    file, _ = mktemp()

    # Write input data
    s.Input.example(file)

    # Read the input data
    s.Input(file)

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
    s.Input.example(file)

    # Read input data
    s.Input(file)

    # Reset values
    s.Input.reset!()

    # Test values
    @test s.Input.N == 0
    @test s.Input.Δt == 0.0
    @test s.Input.q == 0.0
    @test s.Input.t == []
    @test s.Input.x == []

end

end
