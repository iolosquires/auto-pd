
@echo off
setlocal enabledelayedexpansion

set "file=X:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
set "dir_letter=X"
if not exist "%file%" (
    set "file=Z:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
    set "dir_letter=Z"
)

::look for new files in the last two days

echo looking for new files in the last two days
call %dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\find-dstt.bat

call %dir_letter%:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\check-for-new-dstt-files.bat