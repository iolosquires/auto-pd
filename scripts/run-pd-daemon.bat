@echo off
setlocal enabledelayedexpansion

rem Get the directory of the batch file
set script_dir=%~dp0
for /F "tokens=1,2 delims==" %%a in ('findstr "^" "%script_dir%..\config.ini"') do (set "%%a=%%b")

set "file=%base_dir%recent_rs_files.txt"
set "dir_letter=%base_dir:~0,1%"

echo Deleting all files in "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles"...
del /Q "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles\*"

set "experiment_metadata=C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles\metadata.txt"

for /f "usebackq tokens=1-5 delims=	 " %%A in ("%file%") do (
    echo Copying "%%E" to "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles"
    copy "%%E" "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles" >nul
    
    if errorlevel 1 (
        echo Error copying "%%E" to "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles"
        exit /b 1
    )
    rem --- Extract part after "ms-data\"
    for /f "tokens=3 delims=\" %%A in ("%%E") do (
        set "after=%%A"
        echo After is %%A
    )
)

(echo Instrument is: !after!) > "%experiment_metadata%"

echo Starting Proteome Discoverer 2.4 processing...

for %%F in ("C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles\*.raw") do (
    echo "%%~fF"
    "C:\Program Files\Thermo\Proteome Discoverer Daemon 2.4\System\Release\DiscovererDaemon.exe" -p "C:\Program Files\Thermo\Proteome Discoverer Daemon 2.4\dstt2.param" "%%~fF"
     
)

if %automatic_move_to_proteinchem%==1 (
    echo Moving search results to proteinchem...
    call %base_dir%move-search-to-proteinchem.bat
) else (
    echo Automatic move disabled. Skipping move to proteinchem.
    echo Done.
    exit /b
)


