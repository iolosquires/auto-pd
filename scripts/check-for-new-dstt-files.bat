@echo off
setlocal enabledelayedexpansion

rem Get the directory of the batch file
set script_dir=%~dp0

for /F "tokens=1,2 delims==" %%a in ('findstr "^" "%script_dir%..\config.ini"') do (set "%%a=%%b")

rem Build full file path
set "file=%base_dir%recent_rs_files.txt"

echo Checking file: %file%

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
        call %script_dir%run-pd-daemon.bat
    ) else (
        echo "New File" not found in first line. Exiting without running PD daemon.
        exit /b 0
    )
)

pause