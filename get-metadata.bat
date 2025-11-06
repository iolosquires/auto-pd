@echo off
setlocal enabledelayedexpansion

set /p base_dir=<config.txt
:: Build full file path
set "file=%base_dir%recent_rs_files.txt"
set "dir_letter=%base_dir:~0,1%"

for %%F in ("C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles\*.raw") do (
    echo extracting metadata for "%%~fF"
    ::check if file exists
    if not exist "%%~fF" (
        echo File "%%~fF" cannot be found
        goto :done
    )
    if not exist "%dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\marmoset-raw-metadata\MARMoSET_C-master\MARMoSET_C\MARMoSET\bin\x64\Release\MARMoSET.exe" (
        echo File "%dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\marmoset-raw-metadata\MARMoSET_C-master\MARMoSET_C\MARMoSET\bin\x64\Release\MARMoSET.exe" cannot be found
        goto :done
    )
    
    "%dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\marmoset-raw-metadata\MARMoSET_C-master\MARMoSET_C\MARMoSET\bin\x64\Release\MARMoSET.exe" "%%~fF" "%dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\marmoset-raw-metadata\metadata_lumos.json"
     goto :done
)

:done
echo Metadata extraction complete.

pause