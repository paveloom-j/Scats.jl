# Этот файл содержит определение метода
# для записи входных данных в файл

using Printf

"Метод для записи входных данных в файл"
function write!(input::InputStruct, file::AbstractString)

    open(file, "w") do f

        # Проверка, открылся ли файл для записи
        if !isopen(f)
            throw(ScatsInputNotOpenToWrite(file))
        end

        # Запись данных в файл
        println(f, "Размер выборки\n", input.N)
        @printf(f, "\n%s\n% .15E\n", "Шаг выборки", input.Δt)
        @printf(f, "\n%s\n% .15E\n", "Уровень значимости", input.q)
        println(f, "\nМассив времени")
        println(f, join([ @sprintf "% .15E" t for t in input.t ], "   "))
        println(f, "\nМассив значений")
        println(f, join([ @sprintf "% .15E" x for x in input.x ], "   "))

    end

end
