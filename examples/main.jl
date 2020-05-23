using Scats # Подключение пакета

s = Scats.api() # Создание экземпляра API

s.read_gen!("files/gen") # Считывание параметров
                         # для генератора временного ряда

s.gen!() # Генерация временного ряда (во внутренний объект)

s.write_input("files/input") # Запись входных данных в файл

s.vis_input("files/input", "figures/input.pdf") # Визуализация временного ряда