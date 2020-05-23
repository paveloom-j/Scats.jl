# Этот файл содержит определение метода
# для записи входных данных в файл

"Метод для записи входных данных в файл"
function write(input::InputStruct, file::AbstractString)

    open(file, "w") do f

        # Запись данных в файл
        println(f, "Размер выборки")
        println(f, input.N)
        println(f, "\nШаг выборки")
        println(f, input.Δt)
        println(f, "\nУровень значимости")
        println(f, input.q)
        println(f, "\nМассив времени")
        println(f, input.t)
        println(f, "\nМассив значений")
        println(f, input.x)

    end

end