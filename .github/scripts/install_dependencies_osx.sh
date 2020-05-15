#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки зависимостей на OSX.\n\n"

# Получение скрипта macports-ci
printf "Выполняется скачивание скрипта macports-ci...\n\n"
curl -LO https://raw.githubusercontent.com/GiovanniBussi/macports-ci/master/macports-ci

# Установка MacPorts
printf "\nВыполняется установка MacPorts...\n\n"
source macports-ci install

# Установка ccache
printf "\nВыполняется установка ccache...\n\n"
source macports-ci ccache

# Установка dvipng
printf "\nВыполняется установка dvipng...\n\n"
sudo -N port install dvipng

# Обновление pip3
printf "\nВыполняется обновление pip3...\n\n"
python3 -m pip install --upgrade pip

# Установка модуля matplotlib
printf "\nВыполняется установка модуля matplotlib...\n\n"
pip3 install matplotlib

# Установка пакета texlive-latex-extra
printf "\nВыполняется установка пакета texlive-latex-extra...\n\n"
sudo -N port install texlive-latex-extra

# Установка дополнительных шрифтов из пакета texlive
printf "\nВыполняется установка дополнительных шрифтов из пакета texlive...\n\n"
sudo -N port install texlive-fonts-extra

# Установка кириллических шрифтов из пакета texlive
printf "\nВыполняется установка кириллических шрифтов из пакета texlive...\n\n"
sudo -N port install texlive-lang-cyrillic

# Установка пакета cm-super
printf "\nВыполняется установка пакета cm-super...\n\n"
sudo -N port install cm-super

# Сохранение пакетов в кеш
printf "\nСохранение пакетов в кеш...\n\n"
source macports-ci ccache --save