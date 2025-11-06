
@echo off
setlocal enabledelayedexpansion

set /p base_dir=<config.txt
:: Build full file path

echo looking for new files in the last two days
call %base_dir%find-dstt.bat
call %base_dir%check-for-new-dstt-files.bat

