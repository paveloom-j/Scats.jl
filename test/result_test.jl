# This file contains tests for result type

# A module which contains the code to
# perform tests on .Result module from Scats
module TestResult

using Test                        # A package to perform tests
using Scats: api, internal.Result # API and .Result module from Scats
using Scats.internal.prec         # Precision module from Scats

# Print the header
println("\e[1;32mRUNNING\e[0m: result_test.jl")

# Creating instance of the API
s = api()

# Test values resetting
@testset "Check resetting" begin

    # Set non-default values
    s.Result.Δt = s.Result.q = s.Result.threshold = 1
    s.Result.t = s.Result.x = s.Result.X_FFT_ABS = [1]
    s.Result.ν = s.Result.D = s.Result.c = s.Result.cw = s.Result.Dw = [1]

    # Reset values
    s.Result.reset!()

    # Test values
    @test s.Result.Δt == 0.0
    @test s.Result.q == 0.0
    @test s.Result.threshold == 0.0
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
