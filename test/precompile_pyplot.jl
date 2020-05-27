# Этот файл содержит нагрузку для прекомпиляции PyPlot

import PyPlot

# Получение доступа к глобальным параметрам
rcP = PyPlot.PyDict(PyPlot.matplotlib."rcParams")

# Настройка DPI
rcP["savefig.dpi"] = 300
rcP["figure.dpi"] = 300

# Включение поддержки TeX
rcP["text.usetex"] = true

# Включение поддержки русского языка
if Sys.iswindows()
    rcP["text.latex.preamble"] = [raw"\usepackage[main=russian,english]{babel}"]
else
    rcP["text.latex.preamble"] = [raw"\usepackage[main=russian,english]{babel}", raw"\usepackage{cmlgc}"]
end

# Установка семейства шрифтов для текста внутри математической моды
rcP["mathtext.fontset"] = "cm"

# Установка размеров шрифта
rcP["font.size"] = 18
rcP["legend.fontsize"] = 12

@inline function process()

    # Создание тестового набора данных
    x = range(0; stop=2*pi, length=1000)
    y = sin.(3 * x + 4 * cos.(2 * x))

    # Создание графика
    PyPlot.plot(x, y, color="#425378")

    # Добавление заголовка
    PyPlot.title(raw"\textrm{Исходный временной ряд}")

    # Добавление названий осей
    PyPlot.xlabel(raw"\textrm{Время}")
    PyPlot.ylabel(raw"\textrm{Значения ряда}")

    # Определение имени фигуры
    output_file = "precompile_pyplot.pdf"

    # Сохранение фигуры
    PyPlot.savefig(output_file, bbox_inches="tight")

    # Удаление фигуры
    isfile(output_file) && rm(output_file)

end

for _ in 1:3
    process()
end