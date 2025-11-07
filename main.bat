
@echo off
setlocal enabledelayedexpansion

set /p base_dir=<setup.txt
:: Build full file path

echo looking for new files in the last two days
call %base_dir%scripts/find-dstt.bat
call %base_dir%scripts/check-for-new-dstt-files.bat

