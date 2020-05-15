#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки зависимостей на OSX.\n\n"

# Скачивание скриптов
printf "\nВыполняется скачивание скриптов для автоматической установки TexLive...\n\n"
wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/install-tex.sh
wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/tlmgr.sh
chmod +x install-tex.sh tlmgr.sh

# Обновление pip3
printf "\nВыполняется обновление pip3...\n\n"
python3 -m pip install --upgrade pip

# Установка модуля matplotlib
printf "\nВыполняется установка модуля matplotlib...\n\n"
pip3 install matplotlib

# Установка пакета texlive-latex-extra
printf "\nВыполняется установка пакета collection-latexextra...\n\n"
sudo tlmgr install collection-latexextra

# # Установка дополнительных шрифтов из пакета texlive
printf "\nВыполняется установка дополнительных шрифтов из пакета texlive...\n\n"
sudo tlmgr install collection-fontsextra

# Установка кириллических шрифтов из пакета texlive
printf "\nВыполняется установка кириллических шрифтов из пакета texlive...\n\n"
sudo tlmgr install collection-langcyrillic

# Получение и сохранение пути к Python
printf "\nВыполняется получение и сохранение пути к Python...\n\n"
_PYTHON_PATH=$(which python3)
echo Текущий путь к python3: $_PYTHON_PATH

# Сохранение пути к Python в переменной окружения PYTHON
printf "\nВыполняется сохранение пути к Python в переменную окружения PYTHON...\n\n"
mkdir -p ~/.julia/config/
touch ~/.julia/config/startup.jl
echo ENV[\"PYTHON\"]=\"$_PYTHON_PATH\" >> ~/.julia/config/startup.jl