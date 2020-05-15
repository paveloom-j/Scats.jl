@echo off

:: Вывод названия скрипта
echo. && echo Запущен скрипт для установки Python3 на Windows. && echo.

:: Установка Python3
echo Выполняется установка Python3... && echo.
md C:\ProgramData\python3
choco install python3 --install-directory "C:\ProgramData\python3"

:: Сохранение пути к Python в переменной окружения PYTHON
echo. && echo Выполняется сохранение пути к Python в переменную окружения PYTHON... && echo.

python -V
dir C:\ProgramData\chocolatey\bin\
md %USERPROFILE%\.julia\config
echo ENV["PYTHON"]="C:/ProgramData/chocolatey/bin/python.exe" > %USERPROFILE%\.julia\config\startup.jl

refreshenv