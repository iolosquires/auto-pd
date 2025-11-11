@echo off
setlocal enabledelayedexpansion

set script_dir=%~dp0
echo looking for new files in the last two days
call %script_dir%scripts/find-dstt.bat
call %script_dir%scripts/check-for-new-dstt-files.bat

endlocal