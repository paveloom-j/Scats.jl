#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт для установки зависимостей на Unix системах.\n\n"

# Скачивание пакета MacPorts 2.6 для macOS 10.15 Catalina

printf "Выполняется скачивание пакета.\n\n"
curl -JOL 'https://github.com/macports/macports-base/releases/download/v2.6.2/MacPorts-2.6.2-10.15-Catalina.pkg'

# Получение полного пути к файлу

printf "\nВыполняется получение полного пути к файлу.\n\n"

## Источник скрипта: https://stackoverflow.com/questions/1055671/how-can-i-get-the-behavior-of-gnus-readlink-f-on-a-mac

TARGET_FILE="MacPorts-2.6.2-10.15-Catalina.pkg"

cd `dirname $TARGET_FILE`
TARGET_FILE=`basename $TARGET_FILE`

## Продолжать итерацию по (возможной) цепочке символьных ссылок

while [ -L "$TARGET_FILE" ]
do
    TARGET_FILE=`readlink $TARGET_FILE`
    cd `dirname $TARGET_FILE`
    TARGET_FILE=`basename $TARGET_FILE`
done

## Получение абсолютного пути целевого файла с помощью нахождения физического
## пути той директории, в которой мы находимся, и присоединения к нему
## имени целевого файла.

PHYS_DIR=`pwd -P`
RESULT=$PHYS_DIR/$TARGET_FILE

printf "Полный путь к целевому файлу:\n"
printf $RESULT

# Установка пакета

printf "\n\nВыполняется установка пакета.\n\n"
sudo installer -verbose -pkg $RESULT -target /

# Обновление списков пакетов
printf "Выполняется обновление списка пакетов...\n\n"
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