# This file contains tests for result type

# A module which contains the code to
# perform tests on .Result module from Scats
module TestResult

using Scats.Internal.Prec         # Precision module from Scats
using Scats: Internal.Result, API # API and .Result module from Scats
using Test                        # A package to perform tests

# Print the header
println("\e[1;32mRUNNING\e[0m: result_test.jl")

# Creating instance of the API
s = API()

# Test values resetting
@testset "Check resetting" begin

    # Set non-default values
    s.Result.Δt = s.Result.q = s.Result.threshold = 1
    s.Result.t = s.Result.x = s.Result.X_FFT_ABS = [1]
    s.Result.ν = s.Result.D = s.Result.c = s.Result.cw = s.Result.Dw = [1]

    # Reset values
    s.Result.reset!()

    # Test values
    @test s.Result.Δt == 0
    @test s.Result.q == 0
    @test s.Result.threshold == 0
    @test s.Result.t == []
    @test s.Result.x == []
    @test s.Result.X_FFT_ABS == []
    @test s.Result.ν == []
    @test s.Result.D == []
    @test s.Result.c == []
    @test s.Result.cw == []
    @test s.Result.Dw == []

end

end
