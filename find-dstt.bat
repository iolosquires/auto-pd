:: look in folders on msdata for .dstt files in Astral,Bstral,Lumos and 480
@echo off
setlocal enabledelayedexpansion

set "file=X:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
set "dir_letter=X"
if not exist "%file%" (
    set "file=Z:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
    set "dir_letter=Z"
)

if exist "%file%" (
    del "%file%"
    echo Deleted: %file%
)


set Month_01=January
set Month_02=February
set Month_03=March
set Month_04=April
set Month_05=May
set Month_06=June
set Month_07=July
set Month_08=August
set Month_09=September
set Month_10=October
set Month_11=November
set Month_12=December

set CurrMonth=%date:~3,2%

:: Convert to number
set /a prev=1%CurrMonth% - 1
set /a prev=prev %% 100

:: Add leading zero if needed
if !prev! lss 10 (set "PrevMonth=0!prev!") else set "PrevMonth=!prev!"

set Month1=!Month_%CurrMonth%!
set "dateString1=%CurrMonth%_%Month1%"

set Month2=!Month_%PrevMonth%!
set "dateString2=%PrevMonth%_%Month2%"

echo dir_letter=%dir_letter%

for %%f in (mrc-astral
            mrc-bstral
            fsfnnr2
            minint-vgcqtij
            ) do ( 

                if /i "!dir_letter!"=="Z" ( 
                echo dir_letter is Z
                set "datePath1=Z:\ms-data\%%f\%date:~6,4%\%dateString1%"
                set "datePath2=Z:\ms-data\%%f\%date:~6,4%\%dateString2%"
                )
                if /i "!dir_letter!"=="X" (
                echo dir_letter is X
                set "datePath1=X:\ms-data\%%f\%date:~6,4%\%dateString1%"
                set "datePath2=X:\ms-data\%%f\%date:~6,4%\%dateString2%"
                )

                if exist "!datePath1!\" (
                    echo Searching in !datePath1!...
                    robocopy "!datePath1!" "C:\Users" *_RS_*.raw /S /L /NJH /NJS /NDL /FP /MAXAGE:7  >> "!dir_letter!:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
                    robocopy "!datePath1!" "C:\Users" *_AKnebel_*.raw /S /L /NJH /NJS /NDL /FP /MAXAGE:7  >> "!dir_letter!:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
                ) else (
                    echo Skipping, directory not found: !datePath1!
                )
                if exist "!datePath2!\" (
                    echo Searching in !datePath2!...
                    robocopy "!datePath2!" "C:\Users" *_RS_*.raw /S /L /NJH /NJS /NDL /FP /MAXAGE:7 >> "!dir_letter!:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
                    robocopy "!datePath2!" "C:\Users" *_AKnebel_*.raw /S /L /NJH /NJS /NDL /FP /MAXAGE:7  >> "!dir_letter!:\proteinchem\IoloSquires\00-Projects\OwnProjects\auto-pd\recent_rs_files.txt"
                ) else (
                    echo Skipping, directory not found: !datePath2!
                )
            )

