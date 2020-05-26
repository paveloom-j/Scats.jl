# Этот файл содержит определение метода
# для визуализации входных данных

"Функция для пропуска двух строк и проверки на EOF"
@inline function skip(io::IO, file::AbstractString)

        # Пропуск строки
        readline(io)

        # Проверка на неожиданный конец файла
        if eof(io)
            throw(ScatsVisEOF(file))
        end

end

"Метод для визуализации входных данных"
function vis_input(input_file::AbstractString, output_file::AbstractString = "input.pdf")

    # Удаление лишних символов
    file = strip(input_file)

    # Проверка, существует ли файл
    if !isfile(file)
        throw(ScatsVisNotAFile(file))
    end

    # Настройка параметров графиков
    plot_setup()

    # Открытие файла для считывания
    open(file, "r") do f

        # Проверка на неожиданный конец файла
        if eof(f)
            throw(ScatsVisEOF(file))
        end

        # Пропуск строки
        readline(f)

        # Проверка на неожиданный конец файла
        if eof(f)
            throw(ScatsVisEOF(file))
        end

        # Считывание размера выборки
        N = try
            parse(IT, split(readline(f))[1])
        catch
            throw(ScatsVisWR_N(file))
        end

        # Проверка на неожиданный конец файла
        if eof(f)
            throw(ScatsVisEOF(file))
        end

        for _ in 1:8
            skip(f, file)
        end

        # Считывание массива времени
        t = try
            parse.(RT, split(readline(f))[1:N])
        catch
            throw(ScatsVisWR_t(file))
        end

        for _ in 1:2
            skip(f, file)
        end

        # Считывание массива значений
        x = try
            parse.(RT, split(readline(f))[1:N])
        catch
            throw(ScatsVisWR_x(file))
        end

        # Создание графика
        plot(t, x, color="#425378")

        # Добавление заголовка
        title(raw"\textrm{Исходный временной ряд}")

        # Добавление названий осей
        xlabel(raw"\textrm{Время}")
        ylabel(raw"\textrm{Значения ряда}")

        # Сохранение фигуры
        savefig(output_file, bbox_inches="tight")

    end

end