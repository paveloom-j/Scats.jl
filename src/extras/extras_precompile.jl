# Этот файл содержит функцию для генерации скрипта для прекомпиляции этого пакета или пакета PyPlot

@inline function header()

    println("\n     Скрипт для прекомпиляции будет создан в текущей директории (precompile.jl)")
    println("     Вызовите его из терминала / командной строки с помощью `julia precompile.jl`")

end

@inline function check_precompile!()

    if isfile("precompile.jl")
        println("\n     Файл precompile.jl уже существует. Хотите перезаписать его? (y/n)")
        while true
            print("     ")
            answer = readline()
            if lowercase(answer) == "y"
                global exists = true
                break
            elseif lowercase(answer) == "n"
                println("\n     Скрипт не будет обновлен.")
                return(1)
            else
                println("     Пожалуйста, ответьте на вопрос (y/n).")
            end
        end
    end

end

@inline function _precompile(package)

    if lowercase(package) == "scats"

        header()

        global exists = false

        # Проверка, существует ли precompile.jl
        try
            if check_precompile!() == 1
                return
            end
        catch
            return
        end

        open("precompile.jl", "w") do f

            println(f, "# Этот файл содержит скрипт для создания пользовательского образа системы для пакета Scats")

            precompile_path = joinpath(dirname(dirname(Base.find_package("Scats"))), "test", "precompile_scats.jl")
            if Sys.iswindows()
                precompile_path = replace(precompile_path, "\\" => "/")
            end

            println(f, "\nusing Pkg")
            println(f, "Pkg.add(\"PackageCompiler\")")
            println(f, "using PackageCompiler")
            println(f, "create_sysimage(:Scats,")
            println(f, string(" "^17, "sysimage_path=\"scats_image.so\","))
            println(f, string( " "^17, "precompile_execution_file=\"", precompile_path, "\")"))

        end

        if exists == true
            println("\n     Скрипт обновлен. Его пропуск создаст образ системы scats_image.so в текущей директории.")
        else
            println("\n     Скрипт создан. Его пропуск создаст образ системы scats_image.so в текущей директории.")
        end

    elseif lowercase(package) == "pyplot"

        header()

        global exists = false

        # Проверка, существует ли precompile.jl
        try
            if check_precompile!() == 1
                return
            end
        catch
            return
        end

        open("precompile.jl", "w") do f

            println(f, "# Этот файл содержит скрипт для создания пользовательского образа системы для пакета PyPlot")

            precompile_path = joinpath(dirname(dirname(Base.find_package("Scats"))), "test", "precompile_pyplot.jl")
            if Sys.iswindows()
                precompile_path = replace(precompile_path, "\\" => "/")
            end

            println(f, "\nusing Pkg")
            println(f, "Pkg.add(\"PackageCompiler\")")
            println(f, "using PackageCompiler")
            println(f, "create_sysimage(:Scats,")
            println(f, string(" "^17, "sysimage_path=\"pyplot_image.so\","))
            println(f, string( " "^17, "precompile_execution_file=\"", precompile_path, "\")"))

        end

        if exists == true
            println("\n     Скрипт обновлен. Его пропуск создаст образ системы pyplot_image.so в текущей директории.")
        else
            println("\n     Скрипт создан. Его пропуск создаст образ системы pyplot_image.so в текущей директории.")
        end

    else

        println("\n     Неизвестный аргумент. Укажите один из следующих вариантов: Scats, PyPlot.")

    end

end