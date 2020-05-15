@echo off
setlocal enableextensions

:: Вывод названия скрипта
echo. && echo Запущен скрипт для установки зависимостей на Windows. && echo.

:: Установка Python3
echo Выполняется установка Python3... && echo.
choco install python3

:: Получение пути к Python
echo. && echo Выполняется получение и сохранение пути к Python... && echo.

for /F "tokens=* USEBACKQ" %%F in (`where python3`) do (set _PYTHON_PATH=%%F)
set "_PYTHON_PATH=%_PYTHON_PATH:\=/%"
echo Текущий путь к python3: %_PYTHON_PATH%

:: Сохранение пути к Python в переменной окружения PYTHON
echo. && echo Выполняется сохранение пути к Python в переменную окружения PYTHON....

md %USERPROFILE%\.julia\config
echo ENV["PYTHON"]="%_PYTHON_PATH%" > %USERPROFILE%\.julia\config\startup.jl

endlocal