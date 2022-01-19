@ECHO OFF

ECHO Checking if the bash script is called and executed via curl | cmd
if "%0" == "%%0" (
 REM Update: Unsure what I meant here. It's not possible to convert current Command Prompt to the one with Administrative privilegies
 REM The new instance is launched by MSHTA, even if the mshta is forced to be in the same command prompt.
 
 REM TODO: Reinitiates on the same non-administrative Command Prompt. 
 REM Needs to make another Command Prompt with Administrator Privilegies.
 REM Look up, for window closing mechanic: https://github.com/vaido-world/vaido-world.github.io/edit/master/index.html
 REM Do we really need a prompt for administrative privilegies, it does not provide for a smooth installation. 
 REM Without Administrative Privilegies there is no way to modify registry or update System Wide Path variable at all.
 curl --location "https://github.com/vaido-world/Download-D-Compiler-Windows-10/raw/main/windows10-download-dmd.cmd" -O
 cls
 call ./windows10-download-dmd.cmd
)


ECHO Asking for elevation of privilegies (Required only For Adding to PATH variable)
ECHO  Starting a random program to check for elevation error.
ECHO  Checking for ERRORLEVEL that is higher than 1.
ECHO _____________________________
NET SESSION 1>NUL & IF ERRORLEVEL 1 GOTO :ELEVATE



ECHO Setting the installation folder
mkdir "%SystemDrive%/D/"
cd "%SystemDrive%/D/"

ECHO _____________Extracting .zip file_____________
mkdir "./7za/"
curl "https://www.7-zip.org/a/7za920.zip" -O
move "7za920.zip" "./7za/"
tar -xf "./7za/7za920.zip" -C "./7za/"


ECHO _____________Downloading D language Compiler_____________
curl "https://github.com/dlang/dmd/releases/download/nightly/dmd.master.windows.7z" --ssl --location -O

ECHO Extracting .7z file
"./7za/7za.exe" "x" "./dmd.master.windows.7z"

ECHO Testing D compiler
".\dmd2\windows\bin\dmd.exe" --version
".\dmd2\windows\bin64\dmd.exe" --version

ECHO Adding to PATH variable
curl -L "https://github.com/vaido-world/Download-D-Compiler-Windows-10/raw/main/add_to_path.cmd" -O
move "./add_to_path.cmd" "./dmd2/windows/bin/"
call "./dmd2/windows/bin/add_to_path.cmd"


EXIT /B
:ELEVATE
CD /d "%~dp0"
MSHTA "javascript: new ActiveXObject('shell.application').ShellExecute('%~nx0', '%*', '', 'runas', 1); close();"
EXIT /B
