@ECHO OFF
:: setlocal enabledelayedexpansion

::setx /M asd "asd"

REM Removes from path variable
::set "rem=%path:C:\Users\Juozas\AppData\Local\GitHubDesktop\bin=%"
::echo %rem%





set "current_directory=%~dp0"


REM Check if Path already exists.
echo "%path%" | findstr /c:"%current_directory%" >nul
IF %ERRORLEVEL% GTR 0 (
	ECHO not found
	
	set "path=%path%%current_directory%"
	reg.exe "ADD" "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "%path%" /f
	::  trigger WM_SETTINGCHANGE broadcast 
	::setx /M asd "asd"
	
	:: Notice that path already is here
	echo "%current_directory%" > "%appdata%/dmd-path-environment-variable.txt"

	

)

	pause

