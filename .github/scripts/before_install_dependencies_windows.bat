@echo off

:: Вывод названия скрипта
echo. && echo Запущен скрипт для установки Python3 на Windows. && echo.

:: Установка Python3
echo Выполняется установка Python3... && echo.
choco install python3

:: Сохранение пути к Python в переменной окружения PYTHON
echo. && echo Выполняется сохранение пути к Python в переменную окружения PYTHON... && echo.

echo dir c\python38
dir C:\Python38

md %USERPROFILE%\.julia\config
echo ENV["PYTHON"]="C:/Python38/bin/python3.exe" > %USERPROFILE%\.julia\config\startup.jl