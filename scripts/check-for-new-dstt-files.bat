@echo off
setlocal enabledelayedexpansion

rem Get the directory of the batch file
set script_dir=%~dp0

set /p base_dir=<%script_dir%..\setup.txt

rem Build full file path
set "file=%base_dir%recent_rs_files.txt"
set "dir_letter=%base_dir:~0,1%"

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