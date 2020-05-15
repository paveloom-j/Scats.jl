#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки необходимых пакетов из TexLive.\n\n"

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