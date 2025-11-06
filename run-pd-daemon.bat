@echo off
setlocal enabledelayedexpansion

set /p base_dir=<config.txt
:: Build full file path
set "file=%base_dir%recent_rs_files.txt"
set "dir_letter=%base_dir:~0,1%"

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

echo Deleting all .raw files in "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles"...
del /Q "C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles\*.raw"
echo Done.

call %dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\move-search-to-proteinchem.bat