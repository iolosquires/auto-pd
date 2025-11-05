
@echo off
setlocal enabledelayedexpansion

set /p base_dir=<config.txt
:: Build full file path
set "file=%base_dir%recent_rs_files.txt"
::look for new files in the last two days

echo looking for new files in the last two days
call %dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\find-dstt.bat
call %dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\check-for-new-dstt-files.bat