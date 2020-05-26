@echo off
setlocal EnableDelayedExpansion

:: Скрипт-аналог Make-файла для Windows

:: Смена кодировки
for /f "delims=" %%i in ('chcp') do set chcp_output=%%i
for %%i in (%chcp_output%) do set "chcp_code=%%i"
if %chcp_code% neq 65001 chcp 65001 > nul 2>&1

:: Проверка не передачу лишних аргументов
set argCount=0

for %%x in (%*) do (
   set /A argCount+=1
)

if %argCount% gtr 1 (
	echo Пожалуйста, передайте только один параметр.
	goto :eof
)

:: Правило по умолчанию
if "%~1"=="" (
	make help
	goto :eof
)

:: Правило для вывода справки
if "%~1"=="help" (
	echo. && echo      Этот скрипт поможет в пропуске примеров и прекомпиляции модуля.
     echo      Перед использованием убедитесь, что установлены модуль и необходимые зависимости.&& echo.
	echo      Доступные правила: && echo.
	echo      make example — пропустить пример (examples/main.jl^)
     echo      make precompile — скомпилировать пользовательский образ системы
	echo      make example-fast — пропустить пример, используя пользовательский образ
     echo                          системы, созданный с помощью правила make precompile
	goto :eof
)

:: Правило для пропуска примера
if "%~1"=="example" (
	cd examples && julia main.jl && cd ../
	goto :eof
)

:: Правило для прекомпиляции модуля
if "%~1"=="precompile" (
	julia -e "using Scats; Scats.precompile(true, true);"
	julia precompile.jl
	goto :eof
)

:: Правило для пропуска примера с использованием пользовательского
:: образа системы, созданного с помощью правила make precompile
if "%~1"=="example-fast" (
	cd examples && julia --sysimage="scats_image.so" main.jl && cd ../
	goto :eof
)

:: Вызов неизвестного правила
echo Неизвестное правило. Для справки вызовите make help.