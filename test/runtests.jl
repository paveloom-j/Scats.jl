# Этот файл указывает тесты для модуля Scats.jl

fatalerrors = length(ARGS) > 0 && ARGS[1] == "-f"
quiet = length(ARGS) > 0 && ARGS[1] == "-q"
anyerrors = false

tests = ["gen_test.jl", "input_test.jl", "result_test.jl"]

println("Пропуск тестов:")

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
    throw("Некоторые тесты не завершились удачно.")
end