@echo off
rem Batchfile to manage 64-bits binaries in a 32-bits TeX Live installation
rem Public domain
rem Written in 2020 by Siep Kroonenberg

setlocal enableextensions
if /i x%1 == xhelp goto help
if /i x%1 == x-help goto help
if /i x%1 == x--help goto help
if /i x%1 == x-h goto help
if /i x%1 == x/? goto help

rem Other options depend on sufficient permissions.

set zipfile=
if x%1 == x goto nozip
if /i %1 == rescan goto nozip
if /i %1 == remove goto nozip
if not exist "%~dpn1.zip" goto help

set zipfile=%~dpn1.zip
for %%z in ("%zipfile%") do set zipfile=%%~sz

:nozip

rem we are going to need powershell for one or two things:
set pwshell=powershell.exe -NoLogo -NonInteractive -NoProfile

rem Is windows 64-bits (AMD64)?
if %PROCESSOR_ARCHITECTURE% == x86 (
rem The value x86 can happen from 32-bits windows\syswow64\cmd.exe
rem where we need to check another variable:
if not "%PROCESSOR_ARCHITEW6432%" == "AMD64" (
echo This version of Windows is 32-bits. Aborting.
exit /b
)
)

rem TL on searchpath?
kpsewhich -var-value=TEXMFROOT >nul 2>&1
if errorlevel 1 (
echo TeX Live not on searchpath. Aborting.
exit /b
)

for /f "usebackq delims=" %%y in (`kpsewhich -var-value=TEXMFROOT`) do set tlroot=%%y
set tlroot=%tlroot:/=\%

pushd "%tlroot%"
set rootnow=%cd%

rem need release for checking the need for elevation
for /f "usebackq tokens=5 skip=1" %%y in (`find "TeX Live" release-texlive.txt`) do set tlrel=%%y

rem rem elevation needed if HKLM uninstaller reg key exists
set admin_inst=
reg query HKLM\software\microsoft\windows\currentversion\uninstall\texlive%tlrel% /ve >nul 2>&1
if errorlevel 1 (
reg query HKLM\software\wow6432node\microsoft\windows\currentversion\uninstall\texlive%tlrel% /ve >nul 2>&1
if errorlevel 1 goto doit
)
set admin_inst=1

rem elevated?
net session >nul 2>&1
if not errorlevel 1 goto doit

rem restart with elevation (-verb runas)
if x"%zipfile%" == x"" set shargs=/k %~s0 %*
if not x"%zipfile%" == x"" set shargs=/k %~s0 "%zipfile%"
%pwshell% -Command "Start-Process cmd -Verb RunAs -ArgumentList '%shargs%'"
exit /b

:doit
rem full path shortcut to be added or removed, will be used later on
set shortcut=microsoft\windows\start menu\programs\tex live %tlrel%
if "%admin_inst%" == "" (
  set shortcut=%appdata%\%shortcut%
) else (
  set shortcut=%programdata%\%shortcut%
)
set shortcut=%shortcut%\TeX Live %tlrel% 64-bits.lnk

rem now look again at arguments, if any
if x%1 == x goto download
if /i %1 == install goto download
if /i %1 == rescan goto rescan
if /i %1 == remove goto remove
if not "%zipfile%" == "" goto unpack

:download

if not exist temp md temp
if exist temp goto tempok
echo Cannot create %tlroot%\temp
exit /b
:tempok

set urldir=http://mirror.ctan.org/systems/win32/w32tex/TLW64
cd temp
..\tlpkg\installer\wget\wget.exe -N %urldir%/tl-win64.zip
..\tlpkg\installer\wget\wget.exe -N %urldir%/00README.TLW64
set zipfile=%cd%\tl-win64.zip
cd ..

:unpack
if exist bin\win64 del bin\win64\*
bin\win32\unzip "%zipfile%"
echo 64-bits binaries unpacked

rem create menu shortcut
set shargs=/k path %tlroot%\bin\win64;%tlroot%\bin\win32;%%path%%
set cmd=$ws = new-object -comobject wscript.shell
set cmd=%cmd%; $s = $ws.createshortcut('%shortcut%')
set cmd=%cmd%; $s.targetpath = 'cmd'
set cmd=%cmd%; $s.arguments = '%shargs%'
set cmd=%cmd%; $s.workingdirectory = '%%userprofile%%'
set cmd=%cmd%; $s.save()
rem powershell will silently overwrite an existing shortcut
%pwshell% -command "%cmd%"
echo Shortcut created

:rescan
cd %rootnow%
rem empty set ok
for %%f in (bin\win64\*.ex) do ren %%f %%~nf.exe 2>nul
for %%f in (bin\win64\*.ba) do ren %%f %%~nf.bat 2>nul

for %%f in (bin\win64\*.exe) do (
  if not exist bin\win32\%%~nxf ren %%f %%~nf.ex
)
for %%f in (bin\win64\*.bat) do (
  if not exist bin\win32\%%~nxf ren %%f %%~nf.ba
)
Echo Done scanning
goto eof

:remove
del "%shortcut%"
del "%rootnow%\bin\win64\*.*"
rd "%rootnow%\bin\win64"
echo Done removing
goto eof

:help
echo tl64 will download and install 64-bits binaries for TeX Live.
echo It also creates a menu item for a command-prompt which gives priority
echo to 64-bits binaries. 64-bits binaries without corresponding 32-bits
echo counterparts are deactivated (by changing the extension to .ex).
echo.
echo This script will not run on a 32-bits Windows installation.
echo.
echo tl64 help      - Display this text and exit.
echo tl64           - Download and install. Old versions are replaced silently.
echo tl64 install   - As above
echo tl64 ^<zipfile^> - Install 64-bits binaries from ^<zipfile^>.
echo tl64 rescan    - Recheck which binaries should be deactivated,
echo                  e.g. when packages have been added or removed
echo tl64 remove    - Remove 64-bits binaries and the menu item.

endlocal
:eof
