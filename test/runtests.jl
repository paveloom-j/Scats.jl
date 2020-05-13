# Этот файл указывает тесты для модуля Scats.jl

fatalerrors = length(ARGS) > 0 && ARGS[1] == "-f"
quiet = length(ARGS) > 0 && ARGS[1] == "-q"
anyerrors = false

my_tests = ["gen_test.jl", "input_test.jl", "result_test.jl", "vis_test.jl"]

println("Пропуск тестов:")

for my_test in my_tests
    try
        include(my_test)
        println("\033[1m\033[32mPASSED\033[0m: $(my_test)")
    catch e
        global anyerrors = true
        println("\033[1m\033[31mFAILED\033[0m: $(my_test)")
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