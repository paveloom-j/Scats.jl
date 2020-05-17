#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки TexLive и соответствующих пакетов.\n\n"

# Установка TexLive и tlmgr
printf "Выполняется установка TexLive и tlmgr...\n\n"
. ./install-tex.sh

# Установка пакета dvipng
printf "Выполняется установка пакета dvipng...\n\n"
sudo tlmgr install dvipng

# Установка пакета texlive-latex-extra
printf "\nВыполняется установка пакета collection-latexextra...\n\n"
sudo tlmgr install collection-latexextra

# # Установка дополнительных шрифтов из пакета texlive
printf "\nВыполняется установка дополнительных шрифтов из пакета texlive...\n\n"
sudo tlmgr install collection-fontsextra

# Установка кириллических шрифтов из пакета texlive
printf "\nВыполняется установка кириллических шрифтов из пакета texlive...\n\n"
sudo tlmgr install collection-langcyrillic