@echo off

:: Вывод названия скрипта
echo. && echo Запущен скрипт для установки зависимостей на Windows. && echo.

:: Обновление pip
echo Выполняется обновление pip... && echo.
python -m pip install --upgrade pip

:: Установка matplotlib
echo. && echo Выполняется установка matplotlib... && echo.
python -m pip install matplotlib

:: Установка MiKTeX
echo. && echo Выполняется установка MiKTeX... && echo.
REM wget https://miktex.org/download/win/miktexsetup-x64.zip
REM unzip *.zip
REM miktexsetup --package-set=basic download
REM miktexsetup install
REM choco install miktex
curl -o miktex.exe https://miktex.org/download/ctan/systems/win32/miktex/setup/windows-x64/basic-miktex-2.9.7417-x64.exe
miktex --unattended --auto-install=yes

:: Сохранение пути к Python в переменной окружения PYTHON
echo. && echo Выполняется сохранение пути к Python в переменную окружения PYTHON... && echo.

python -V
echo.

md %USERPROFILE%\.julia\config
echo ENV["PYTHON"]="C:/Python38/python.exe" > %USERPROFILE%\.julia\config\startup.jl