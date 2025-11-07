@echo off
setlocal enabledelayedexpansion

set "month_01=January"
set "month_02=February"
set "month_03=March"
set "month_04=April"
set "month_05=May"
set "month_06=June"
set "month_07=July"
set "month_08=August"
set "month_09=September"
set "month_10=October"
set "month_11=November"
set "month_12=December"

rem Adjust the substring below if your date format is different (this assumes MM/DD/YYYY)
set "CurrMonth=%date:~3,2%"

rem Get previous month (handle January wrap-around)
set /a PrevMonth=1%CurrMonth%-1
if %PrevMonth% lss 10 (
    set "PrevMonth=0%PrevMonth%"
) else (
    set "PrevMonth=%PrevMonth%"
)

set "PrevMonth=%PrevMonth:~-2%"
set "CurrMonthName=!month_%CurrMonth%!"
set "PrevMonthName=!month_%PrevMonth%!"

set "dateString=%CurrMonth%_%CurrMonthName%"
set "PrevMonthName=!month_%PrevMonth%!"
set "PrevdateString=%PrevMonth%_%PrevMonthName%"
set "CurrYear=%date:~6,9%"

echo dateString=!dateString!
echo PrevdateString=!PrevdateString!

rem Get the directory of the batch file
set script_dir=%~dp0

set /p base_dir=<%script_dir%..\setup.txt
set "dir_letter=%base_dir:~0,1%"
:: Build full file path
set "file=%base_dir%recent_rs_files.txt"

for /f "usebackq tokens=5 delims=	 " %%A in ("%file%") do (
    set "fileStr=%%A"
)

for /f "tokens=4-7 delims=\" %%A in ("%fileStr%") do (
    set "filename=%%D"
)

for /f "tokens=1-3 delims=_" %%A in ("%filename%") do (
    set "filename1=%%A"
)

set "pcdir_search=%filename1%_RS_106747"
set "dir1=%dir_letter%:\proteinchem\%CurrYear% logins\!dateString!"

echo Searching in !dir1! for folders matching *!pcdir_search!*...


for /d %%F in ("!dir1!\*!pcdir_search!*") do (
    set "save_dir=%%F"
    echo Found matching directory: !save_dir!
    goto :foundDir
)

rem === Loop through folders ===
set "dir=%dir_letter%:\proteinchem\%CurrYear% logins\!PrevdateString!"

echo Nothing found in !dir1!, searching in !dir! for folders matching *!pcdir_search!*...

for /d %%F in ("!dir!\*!pcdir_search!*") do (
    echo %%~nxF
    set "save_dir=%%F"
    echo Found matching directory: !save_dir!
    goto :foundDir
)

:foundDir

rem check if save_dir directory exists

if not defined save_dir (
    echo No matching directory found. Exiting.
    pause
    exit /b
)

echo Using directory: !save_dir!

rem if save_dir found, check the directory exists
if not exist "!save_dir!" (
    echo Directory !save_dir! does not exist. Exiting.
    pause
    exit /b
)

echo !save_dir! exists. Proceeding...

rem check if any files exist in PublicFiles
if not exist "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles\*" (
    echo No files found in PublicFiles. Exiting.
    pause
    exit /b
)

echo Files found in PublicFiles. Proceeding to move files...

::move remaining files from Publicfiles to %pcdir%
move "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles\*" "!save_dir!"
del /Q "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles\*"

echo Files moved to !save_dir!.
echo Script completed.
pause