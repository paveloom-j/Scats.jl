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
miktexsetup --verbose --local-package-repository=C:\miktex-repository --package-set=basic download
miktexsetup --verbose --local-package-repository=C:\miktex-repository --package-set=basic --shared --user-config="%APPDATA%\MiKTeX\2.9" --user-data="%LOCALAPPDATA%\MiKTeX\2.9" --user-install="%APPDATA%\MiKTeX\2.9" install