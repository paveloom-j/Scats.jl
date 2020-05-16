@echo off

:: Вывод названия скрипта
echo. && echo Запущен скрипт для установки зависимостей на Windows. && echo.

:: Обновление pip
echo Выполняется обновление pip... && echo.
python -m pip install --upgrade pip

:: Установка matplotlib
echo. && echo Выполняется установка matplotlib... && echo.
python -m pip install matplotlib

:: Установка texlive
echo. && echo Выполняется установка TexLive... && echo.
wget http://mirrors.mi.ras.ru/CTAN/systems/texlive/tlnet/install-tl.zip
unzip install-tl.zip
cd install-tl-2020*
install-tl-windows -repository http://ctan.mirror.rafal.ca/systems/texlive/tlnet
tlmgr init-usertree

:: Сохранение пути к Python в переменной окружения PYTHON
echo. && echo Выполняется сохранение пути к Python в переменную окружения PYTHON... && echo.

C:/Python38/python.exe -V
echo.

md %USERPROFILE%\.julia\config
echo ENV["PYTHON"]="C:/Python38/python.exe" > %USERPROFILE%\.julia\config\startup.jl