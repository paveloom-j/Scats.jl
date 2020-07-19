# This file contains tests for result type

# A module which contains the code to
# perform tests on .result module from Scats
module TestResult

using Test                        # A package to perform tests
using Scats: api, internal.result # API and .result module from Scats
using Scats.internal.prec         # Precision module from Scats

# Print the header
println("\e[1;32mRUNNING\e[0m: result_test.jl")

# Creating instance of the API
s = api()

# Test values resetting
@testset "Check resetting" begin

    # Set non-default values
    s.result.Δt = s.result.q = s.result.threshold = 1
    s.result.t = s.result.x = s.result.X_FFT_ABS = [1]
    s.result.ν = s.result.D = s.result.c = s.result.cw = s.result.Dw = [1]

    # Reset values
    s.result.reset!()

    # Test values
    @test s.result.Δt == 0.0
    @test s.result.q == 0.0
    @test s.result.threshold == 0.0
    @test s.result.t == []
    @test s.result.x == []
    @test s.result.X_FFT_ABS == []
    @test s.result.ν == []
    @test s.result.D == []
    @test s.result.c == []
    @test s.result.cw == []
    @test s.result.Dw == []

end

end
