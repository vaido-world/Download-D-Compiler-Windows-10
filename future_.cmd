@ECHO OFF
SETLOCAL EnableDelayedExpansion
set "path=!path!"

echo "!path!"
pause

SET "CURRENT_DIRECTORY=%~DP0"

echo !CURRENT_DIRECTORY!
echo !path!

:: Check if Path already exists.
echo "!path!" | findstr /c:"!CURRENT_DIRECTORY!" >NUL
echo %ERRORLEVEL%
IF %ERRORLEVEL% GTR 0 (
    ECHO Path is being updated.

    set "path=!path!!CURRENT_DIRECTORY!"


    reg.exe "ADD" "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "!path!\" /f


    )

pause
