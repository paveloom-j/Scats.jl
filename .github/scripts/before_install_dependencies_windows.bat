@echo off

:: Вывод названия скрипта
echo. && echo Запущен скрипт для установки Python3 на Windows. && echo.

:: Установка Python3
echo Выполняется установка Python3... && echo.
md C:\ProgramData\python3
choco install python3 --override --installarguments "'TargetDir=C:\ProgramData\python3'"

:: Сохранение пути к Python в переменной окружения PYTHON
echo. && echo Выполняется сохранение пути к Python в переменную окружения PYTHON... && echo.

python -V
dir C:\ProgramData\python3
md %USERPROFILE%\.julia\config
echo ENV["PYTHON"]="C:/ProgramData/python3/python.exe" > %USERPROFILE%\.julia\config\startup.jl

refreshenv