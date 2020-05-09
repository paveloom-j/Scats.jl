# Этот файл содержит метод для считывания входных данных

"Функция для пропуска двух строк и проверки на EOF"
@inline function skip(io::IO, file::AbstractString)

        # Пропуск строки
        readline(io)

        # Проверка на неожиданный конец файла
        if eof(io)
            throw(ScatsGenEOF(file))
        end

        # Пропуск строки
        readline(io)

        # Проверка на неожиданный конец файла
        if eof(io)
            throw(ScatsGenEOF(file))
        end

end

"Метод для считывания входных данных"
function read!(input::InputStruct, file::AbstractString)

    # Удаление лишних символов
    file = strip(file)

    # Проверка, существует ли файл
    if !isfile(file)
        throw(ScatsInputNotAFile(file))
    end

    # Открытие файла для считывания
    open(file, "r") do f

        # Проверка, открылся ли файл для считывания
        if !isopen(f)
            throw(ScatsInputNotOpenToRead(file))
        end

        # Проверка на неожиданный конец файла
        if eof(f)
            throw(ScatsInputEOF(file))
        end

        # Пропуск строки
        readline(f)

        # Проверка на неожиданный конец файла
        if eof(f)
            throw(ScatsInputEOF(file))
        end

        # Считывание размера выборки
        try
            input.N = parse(IT, split(readline(f))[1])
        catch
            throw(ScatsInputWR_N(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание шага выборки
        try
            input.Δt = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsInputWR_Δt(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание уровня значимости
        try
            input.q = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsInputWR_q(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание массива времени
        try
            input.t = (parse.(RT, split(readline(f))[1:input.N]))
        catch
            throw(ScatsInputWR_t(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание массива значений
        try
            input.x = (parse.(RT, split(readline(f))[1:input.N]))
        catch
            throw(ScatsInputWR_x(file))
        end

    end

end