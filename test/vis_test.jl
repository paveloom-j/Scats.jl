# Этот файл содержит тесты визуализации данных

module TestVis

using Test
using Scats: api

println("\033[1m\033[32mCHECKING\033[0m: vis_test.jl")

# Создание экземпляра API
s = api()

# Считывание параметров генератора временного ряда
s.read_gen!("files/gen")

# Генерация входных данных
s.gen!()

# Создание временного файла
tmppath, _ = mktemp()

# Запись временного ряда в файл
s.write_input(tmppath)

# Выполнение визуализации входных данных
s.vis.input(tmppath, "")

@testset "Проверка создания графика" begin
    @test isfile("input.pdf")
    @test filesize("input.pdf") > 1000
end

rm("input.pdf")

end