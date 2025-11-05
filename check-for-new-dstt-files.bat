@echo off
setlocal enabledelayedexpansion

set "file=X:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
set "dir_letter=X"
if not exist "%file%" (
    set "file=Z:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
    set "dir_letter=Z"
)

rem if file exists, and first line is empty, stop, otherwise run run-pd-daemon.bat

for /f "usebackq tokens=1 delims=   " %%A in ("%file%") do (
    set "firstLine=%%A"
    echo First line of file: %%A
    goto :checkLine
)
:checkLine
if defined firstLine (
    echo First line: "!firstLine!"
    echo Checking if first line contains "New File"...
    echo !firstLine! | findstr /C:"New File" >nul
    if not errorlevel 1 (
        call %dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\run-pd-daemon.bat
    ) else (
        echo "New File" not found in first line. Exiting without running PD daemon.
        exit /b 0
    )
)

pause