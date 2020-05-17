#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки TexLive и соответствующих пакетов.\n\n"

# Скачивание скриптов
printf "Выполняется скачивание скриптов для автоматической установки TexLive...\n\n"
wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/install-tex.sh
wget https://raw.githubusercontent.com/y-yu/install-tex-travis/master/tlmgr.sh
chmod +x install-tex.sh tlmgr.sh

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

# Установка пакета cm-super
printf "\nВыполняется установка пакета cm-super...\n\n"
sudo tlmgr install cm-super