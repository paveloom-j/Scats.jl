# Этот файл содержит определение метода
# для считывания параметров генератора

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

"Метод для считывания параметров генератора временного ряда"
function read!(gen::GenStruct, file::AbstractString)

    # Удаление лишних пробелов
    file = strip(file)

    # Проверка, существует ли файл
    if !isfile(file)
        throw(ScatsGenNotAFile(file))
    end

    # Открытие файла для считывания
    open(file, "r") do f

        # Проверка на неожиданный конец файла
        if eof(f)
            throw(ScatsGenEOF(file))
        end

        # Пропуск строки
        readline(f)

        # Проверка на неожиданный конец файла
        if eof(f)
            throw(ScatsGenEOF(file))
        end

        # Считывание размера выборки
        try
            gen.N = parse(IT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_N(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание шага выборки
        try
            gen.Δt = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_Δt(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание уровня значимости
        try
            gen.q = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_q(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание параметра α
        try
            gen.α = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_α(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание параметра β
        try
            gen.β = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_β(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание числа гармонических компонент
        try
            gen.r = parse(IT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_r(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание массива амплитуд гармонических компонент
        try
            gen.A = (parse.(RT, split(readline(f))[1:gen.r]))
        catch
            throw(ScatsGenWR_A(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание массива частот гармонических компонент
        try
            gen.ν = (parse.(RT, split(readline(f))[1:gen.r]))
        catch
            throw(ScatsGenWR_ν(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание массива частот гармонических компонент
        try
            gen.ϕ = (parse.(RT, split(readline(f))[1:gen.r]))
        catch
            throw(ScatsGenWR_ϕ(file))
        end

        # Пропуск двух строк
        skip(f, file)

        # Считывание массива частот гармонических компонент
        try
            gen.γ = parse(RT, split(readline(f))[1])
        catch
            throw(ScatsGenWR_γ(file))
        end

    end

    nothing

end