@ECHO off
CLS
GOTO :CHECKPERMS

:CHECKPERMS
    echo Administrative Permissions Required. Detecting Permissions...

    NET SESSION >nul 2>&1
    IF %errorLevel% == 0 (
        echo Success: Administrative Permissions Confirmed. Continuing As Usual... && GOTO :PROMPT
    ) ELSE (
        echo Current Permissions Inadequate. Requesting Elevated Rights... && (powershell start -verb runas '%0' am_admin & exit /b)
    )

:PROMPT
CLS
echo ==================================================================================
echo                               WINDOWS DEBLOAT SCRIPT
echo ==================================================================================
echo.
echo This script will debloat all Windows operating systems from Windows 10 and upward.
echo.
echo The following options can be chosen:
echo.
echo ------------------------------
echo      [1] Run And Exit
echo.
echo      [2] Run And Continue
echo.
echo      [3] Abort
echo ------------------------------
echo.
CHOICE /C 123 /N /M "Enter Your Choice:"
IF ERRORLEVEL 3 GOTO :ABORT
IF ERRORLEVEL 2 GOTO :DEBLOATRUN
IF ERRORLEVEL 1 GOTO :DEBLOATEXIT

:DEBLOATRUN
echo Running Debloat Script...
powershell -command iwr -useb "https://git.io/debloat|iex"
GOTO :NEXT

:DEBLOATEXIT
echo Running Debloat Script...
powershell -command iwr -useb "https://git.io/debloat|iex"
GOTO :EXIT

:NEXT
echo Opening Next Script: Tron Script Downloader...
call "%~dp0/7 Install Tron Script (Optional).bat"

:END
echo The script has been finished. Terminating console in 3 seconds...
timeout /t 3
taskkill /f /im cmd.exe

:ABORT
echo The script has been stopped. No user permissions given. Terminating console in 3 seconds...
timeout /t 3
taskkill /f /im cmd.exe