# This file manages tests for Scats.jl package

# A flag to throw the first captured exception back
fatalerrors = length(ARGS) > 0 && ARGS[1] == "-f"

# A flag to hide additional LoadErrors
quiet = length(ARGS) > 0 && ARGS[1] == "-q"

# A flag to check if any error occurred
anyerrors = false

# Specify tests
tests = ["gen_test.jl", "input_test.jl", "result_test.jl"]

# Print info
println("\e[1;32mRUNNING TESTS:\e[0m Scats")

# Run tests
for test in tests
    try
        include(test)
        println("\e[1;32mPASSED\e[0m: $test")
    catch e
        global anyerrors = true
        println("\e[1;31mFAILED\e[0m: $test")
        if fatalerrors
            rethrow(e)
        elseif !quiet
            showerror(stdout, e, backtrace())
            println()
        end
    end
end

# If anyerrors, throw exception
anyerrors && throw("Some tests have failed.")