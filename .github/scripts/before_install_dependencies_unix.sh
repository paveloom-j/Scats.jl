#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки зависимостей на Unix системах.\n\n"

# Загрузка кеша
printf "Выполняется загрузка кеша...\n\n"

exist() {
     [ -e "$1" ]
}

if exist ~/apt-get-packages/*.deb; then
     sudo mv ~/apt-get-packages/*.deb /var/cache/apt/archives/
     ls /var/cache/apt/archives
fi

# Обновление списков пакетов
printf "\nВыполняется обновление списка пакетов...\n\n"
sudo apt-get update

# Установка dvipng
printf "\nВыполняется установка dvipng...\n\n"
sudo apt-get install dvipng

# Установка python3-dev
printf "\nВыполняется установка python3...\n\n"
sudo apt-get install python3-dev

# Установка pip3
printf "\nВыполняется установка pip3...\n\n"
sudo apt-get install python3-pip

# Обновление pip3
printf "\nВыполняется обновление pip3...\n\n"
python3 -m pip install --upgrade pip

# Установка setuptools
printf "\nВыполняется установка модуля setuptools...\n\n"
pip3 install setuptools

# Установка модуля matplotlib
printf "\nВыполняется установка модуля matplotlib...\n\n"
pip3 install matplotlib

# Установка пакета texlive-latex-extra
printf "\nВыполняется установка пакета texlive-latex-extra...\n\n"
sudo apt-get install texlive-latex-extra

# Установка дополнительных шрифтов из пакета texlive
printf "\nВыполняется установка дополнительных шрифтов из пакета texlive...\n\n"
sudo apt-get install texlive-fonts-extra

# Установка кириллических шрифтов из пакета texlive
printf "\nВыполняется установка кириллических шрифтов из пакета texlive...\n\n"
sudo apt-get install texlive-lang-cyrillic

# Установка пакета cm-super
printf "\nВыполняется установка пакета cm-super...\n\n"
sudo apt-get install cm-super

# Обновление кеша
printf "\nВыполняется обновление кеша...\n\n"
cp /var/cache/apt/archives/*deb ~/apt-get-packages/

# Сохранение пути к Python
printf "Выполняется сохранение пути к Python в переменную окружения PYTHON..."
mkdir -p ~/.julia/config/
echo ENV["PYTHON"]=\"$(which python3)\" > ~/.julia/config/startup.jl