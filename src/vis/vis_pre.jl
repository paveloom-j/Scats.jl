# Этот файл содержит определение функцию,
# выполняющей первоначальную настройку
# параметров графиков PyPlot (Matplotlib)

@inline function plot_setup()

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

end