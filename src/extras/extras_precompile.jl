# Этот файл содержит функцию для генерации скрипта для прекомпиляции этого пакета или пакета PyPlot

@inline function header()

    println("\n     Скрипт для прекомпиляции будет создан в текущей директории (precompile.jl)")
    println("     Вызовите его из терминала / командной строки с помощью `julia precompile.jl`")

end

@inline function check_precompile!(force::Bool, quiet::Bool)

    if isfile("precompile.jl")
        if !force
            println("\n     Файл precompile.jl уже существует. Хотите перезаписать его? (y/n)")
            while true
                print("     ")
                answer = readline()
                if lowercase(answer) == "y"
                    global exists = true
                    break
                elseif lowercase(answer) == "n"
                    println("\n     Скрипт не будет обновлен.\n")
                    return(1)
                else
                    println("     Пожалуйста, ответьте на вопрос (y/n).")
                end
            end
        else
            global exists = true
            if !quiet
                println("\n     Файл precompile.jl уже существует и будет перезаписан.")
            end
        end
    end

end

function precompile(force::Bool=false, quiet::Bool=false)

    if !quiet
        header()
    end

    global exists = false

    # Проверка, существует ли precompile.jl
    try
        if check_precompile!(force, quiet) == 1
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

    if !quiet
        if exists == true
            println("\n     Скрипт обновлен. Его пропуск создаст образ системы scats_image.so в текущей директории.")
        else
            println("\n     Скрипт создан. Его пропуск создаст образ системы scats_image.so в текущей директории.")
        end
    end

    if !quiet
        println()
    end

end

# Функция, сообщающая о запрете изменения
# quiet, если значение force = false
@inline function warning()
    println("\n     Данная функция запрещает указание значения аргумента")
    println("     quiet, если значение аргумента force равно false.\n")
end

_precompile(force::Bool, quiet::Bool) = _precompile(Val(force), quiet)
_precompile(::Val{true}, quiet::Bool) = precompile(true, quiet)
_precompile(::Val{false}) = precompile(false, false)
_precompile(::Val{false}, ::Bool) = warning()

_precompile(; force=true, quiet=false) = _precompile(force, quiet)
_precompile(force::Bool) = precompile(force, false)