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
wget https://miktex.org/download/win/miktexsetup-x64.zip
unzip *.zip
miktexsetup --verbose --local-package-repository=C:\miktex-repository --package-set=complete download
miktexsetup --verbose --local-package-repository=C:\miktex-repository --shared --user-config="%APPDATA%\MiKTeX\2.9" --user-data="%LOCALAPPDATA%\MiKTeX\2.9" --user-install="%APPDATA%\MiKTeX\2.9" --print-info-only install
echo . && echo TEST
find "C:\Program Files\" -name "latex.exe"
find C:\Users\travis\ -name "latex.exe"
dir "C:\Program Files\"
dir "%APPDATA%\MiKTeX\2.9"
dir "%USERPROFILE%\Roaming\MiKTeX\2.9"

:: Сохранение пути к Python в переменной окружения PYTHON
echo. && echo Выполняется сохранение пути к Python в переменную окружения PYTHON... && echo.

python -V
echo.

md %USERPROFILE%\.julia\config
echo ENV["PYTHON"]="C:/Python38/python.exe" > %USERPROFILE%\.julia\config\startup.jl