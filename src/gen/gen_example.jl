# Этот файл содержит метод для генерации примера
# с параметрами генератора временного ряда

function example(file::AbstractString)

    # Удаление лишних символов
    file = strip(file)

    # Проверка, является ли указанный файл директорией
    if isdir(file)
        throw(ScatsGenIsADir(file))
    end

    open(file, "w") do f

        println(f, "Sample size")
        println(f, "230")
        println(f)
        println(f, "Sample step")
        println(f, "1.0")
        println(f)
        println(f, "Significance level")
        println(f, "0.01")
        println(f)
        println(f, "Параметр \\alpha линейного тренда")
        println(f, "0.1")
        println(f)
        println(f, "Параметр \\beta линейного тренда")
        println(f, "0.05")
        println(f)
        println(f, "Число гармонических компонент")
        println(f, "1")
        println(f)
        println(f, "Массив амплитуд гармонических компонент")
        println(f, "1.0")
        println(f)
        println(f, "Массив частот гармонических компонент")
        println(f, "0.1")
        println(f)
        println(f, "Массив фазовых сдвигов гармонических компонент")
        println(f, "0.0")
        println(f)
        println(f, "Отношение «сигнал к шуму»")
        println(f, "0.50")

    end

end