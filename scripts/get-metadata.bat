@echo off
setlocal enabledelayedexpansion

rem Get the directory of the batch file
set script_dir=%~dp0
for /F "tokens=1,2 delims==" %%a in ('findstr "^" "%script_dir%..\config.ini"') do (set "%%a=%%b")

:: Build full file path
set "file=%base_dir%recent_rs_files.txt"
set "dir_letter=%base_dir:~0,1%"

echo Using Rscript at: %Rscript_path%
pause

for %%F in ("C:\ProgramData\Thermo\Proteome Discoverer 2.4\PublicFiles\*.raw") do (
    echo extracting metadata for "%%~fF"
    ::check if file exists
    if not exist "%%~fF" (
        echo File "%%~fF" cannot be found
        goto :done
    )
    "%Rscript_path%" "%%~fF" "get-metadata.R"
     goto :done
)

:done
echo Metadata extraction complete.

pause