@ECHO OFF
SETLOCAL EnableDelayedExpansion

REM Ask for elevation of privilegies
NET SESSION 1>NUL
IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE


REM The Path added to the Environment Path Variable
SET "CURRENT_DIRECTORY=%~DP0"

REM The program begins
ECHO Path is being updated.

REM Get previous path folder and save it into variable.
IF NOT EXIST "!appdata!/previous-dmd-path-environment-variable.txt" GOTO :add_to_path_variable
	set /p previous=<"!appdata!/previous-dmd-path-environment-variable.txt"

	REM Remove quotes from the variable
	set "previous_unquoted_variable=!previous:"=!"

	REM Remove path variable from the previous instance of this script.
	set "path=!path:%previous_unquoted_variable%;=!"
	set "path=!path:%previous_unquoted_variable%=!"
	



:add_to_path_variable
REM Update the path variable
set "path=!path!!CURRENT_DIRECTORY!"

REM Overwrite the Path variable in the Windows Registry
reg.exe "ADD" "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "!path!\" /f

REM Setting a temporary dummy variable so setx will broadcast WM_SETTINGCHANGE so the PATH change is reflected without needing a restart.
SETX /m DUMMY ""
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V DUMMY

REM Keep track of the previous instance Path variable
echo "%current_directory%"> "%appdata%/previous-dmd-path-environment-variable.txt"
    
)
PAUSE





EXIT /B
:ELEVATE
CD /d "%~dp0"
MSHTA "javascript: new ActiveXObject('shell.application').ShellExecute('%~nx0', '', '', 'runas', 1); close();"
EXIT /B


:: Check if Path already exists.
REM echo "!path!" | findstr /c:"!CURRENT_DIRECTORY!\" >NUL
REM IF %ERRORLEVEL% EQU 0 (
REM     ECHO Path already exist.
REM ) ELSE (
REM 	ECHO does not exist
REM )

