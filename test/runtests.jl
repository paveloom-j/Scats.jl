# This file manages tests for Scats.jl package

fatalerrors = length(ARGS) > 0 && ARGS[1] == "-f"
quiet = length(ARGS) > 0 && ARGS[1] == "-q"
anyerrors = false

tests = ["gen_test.jl", "input_test.jl", "result_test.jl"]

println("\033[1m\033[32mRUNNING TESTS\033[0m")

for test in tests
    try
        include(test)
        println("\033[1m\033[32mPASSED\033[0m: $test")
    catch e
        global anyerrors = true
        println("\033[1m\033[31mFAILED\033[0m: $test")
        if fatalerrors
            rethrow(e)
        elseif !quiet
            showerror(stdout, e, backtrace())
            println()
        end
    end
end

if anyerrors
    throw("Some tests failed.")
end