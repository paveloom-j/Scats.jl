#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки зависимостей.\n\n"

# Обновление списков пакетов
printf "Выполняется обновление списка пакетов...\n\n"
sudo apt-get update

# Установка dvipng
sudo apt-get install dvipng

# Установка python3-dev
printf "\nВыполняется установка python3...\n\n"
sudo apt-get install python3-dev

# Установка pip3
printf "\nВыполняется установка pip3...\n\n"
sudo apt-get install python3-pip

# Обновление pip3
printf "\nВыполняется обновление pip3...\n\n"
sudo python3 -m pip install --upgrade pip

# Установка setuptools
printf "\nВыполняется установка модуля setuptools...\n\n"
pip3 install setuptools

# Установка модуля matplotlib
printf "\nВыполняется установка модуля matplotlib...\n\n"
pip3 install matplotlib

# Установка дополнительных шрифтов из пакета texlive
printf "\nВыполняется установка дополнительных шрифтов из пакета texlive...\n\n"
sudo apt-get install texlive-fonts-extra

# Установка кириллических шрифтов из пакета texlive
printf "\nВыполняется установка кириллических шрифтов из пакета texlive...\n\n"
sudo apt-get install texlive-lang-cyrillic

# Установка пакета cm-super
printf "\nВыполняется установка пакета cm-super...\n\n"
sudo apt-get install cm-super