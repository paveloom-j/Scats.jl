@echo off

:: Вывод названия скрипта
echo. && echo Запущен скрипт для установки Python3 на Windows. && echo.

:: Установка Python3
echo Выполняется установка Python3... && echo.
choco install python3

:: Установка matplotlib
echo. && echo Выполняется установка matplotlib... && echo.
C:/Python38/python.exe -m pip install matplotlib

:: Установка texlive
echo. && echo Выполняется установка TexLive... && echo.
.github/scripts/tl64.bat

:: Сохранение пути к Python в переменной окружения PYTHON
echo. && echo Выполняется сохранение пути к Python в переменную окружения PYTHON... && echo.

C:/Python38/python.exe -V
echo.

md %USERPROFILE%\.julia\config
echo ENV["PYTHON"]="C:/Python38/python.exe" > %USERPROFILE%\.julia\config\startup.jl