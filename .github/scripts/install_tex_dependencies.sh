#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки зависимостей.\n\n"

# Обновление списков пакетов
printf "Выполняется обновление списка пакетов...\n\n"
sudo apt-get update

# Установка pip3
printf "Выполняется установка pip3...\n\n"
sudo apt-get install python3-pip

# Обновление pip3
printf "Выполняется обновление pip3...\n\n"
sudo python3 -m pip install --upgrade pip

# Установка setuptools
printf "Выполняется установка модуля setuptools...\n\n"
pip3 install setuptools

# Установка модуля matplotlib
printf "Выполняется установка модуля matplotlib...\n\n"
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