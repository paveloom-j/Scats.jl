#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки зависимостей на OSX.\n\n"

# # Получение скрипта macports-ci
# printf "Выполняется скачивание скрипта macports-ci...\n\n"
# curl -LO https://raw.githubusercontent.com/GiovanniBussi/macports-ci/master/macports-ci

# # Установка MacPorts
# printf "\nВыполняется установка MacPorts...\n\n"
# source macports-ci install

# # Установка ccache
# printf "\nВыполняется установка ccache...\n\n"
# source macports-ci ccache

# # Установка dvipng
# printf "\nВыполняется установка dvipng...\n\n"
# sudo port -N install dvipng

# # Обновление списка пакетов
# printf "Выполняется обновление списка пакетов...\n\n"
# brew update

# # Установка пакета mactex
# printf "\nВыполняется установка пакета mactex...\n\n"
# brew cask install mactex

wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/install-tex.sh
wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/tlmgr.sh
chmod +x install-tex.sh tlmgr.sh

# Обновление путей после установки basictex
printf "\nВыполняется обновление путей после установки basictex...\n\n"
# eval "$(/usr/libexec/path_helper)"
latex -v

# Обновление pip3
printf "\nВыполняется обновление pip3...\n\n"
python3 -m pip install --upgrade pip

# Установка модуля matplotlib
printf "\nВыполняется установка модуля matplotlib...\n\n"
pip3 install matplotlib

# # Установка пакета texlive-latex-extra
# printf "\nВыполняется установка пакета texlive-latex-extra...\n\n"
# sudo port -N install texlive-latex-extra

# # Установка дополнительных шрифтов из пакета texlive
# printf "\nВыполняется установка дополнительных шрифтов из пакета texlive...\n\n"
# sudo port -N install texlive-fonts-recommended

# # Установка кириллических шрифтов из пакета texlive
# printf "\nВыполняется установка кириллических шрифтов из пакета texlive...\n\n"
# sudo port -N install texlive-lang-cyrillic

# # Сохранение пакетов в кеш
# printf "\nСохранение пакетов в кеш...\n\n"
# source macports-ci ccache --save

# Получение и сохранение пути к Python
printf "\nВыполняется получение и сохранение пути к Python...\n\n"
_PYTHON_PATH=$(which python3)
echo Текущий путь к python3: $_PYTHON_PATH

# Сохранение пути к Python в переменной окружения PYTHON
printf "\nВыполняется сохранение пути к Python в переменную окружения PYTHON...\n\n"
mkdir -p ~/.julia/config/
touch ~/.julia/config/startup.jl
echo ENV[\"PYTHON\"]=\"$_PYTHON_PATH\" >> ~/.julia/config/startup.jl