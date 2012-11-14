@echo off

if "%DIT_HOME%" equ "" goto NOT_IN

setlocal ENABLEDELAYEDEXPANSION

if "%~1" equ "" goto USAGE
if "%~2" equ "" goto USAGE

set IMAGE_NAME=%~1
set OUTPUT_FILE=%~2

if exist "%OUTPUT_FILE%" del /q "%OUTPUT_FILE%"

for /f "skip=3 tokens=1,2* delims= " %%i in ('tasklist /fi "imagename eq %IMAGE_NAME%"') do (
    echo %%j >> "%OUTPUT_FILE%"    
)

:END
exit /b 0

:USAGE
echo Usage:
echo    getpid ^<image name^> ^<output file^>
echo.
exit /b 1

:NOT_IN
echo SHOULD BE CALLED UNDER SERVER ENV!
echo.
pause
exit /b 1