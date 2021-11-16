@ECHO OFF


if "%0" == "%%0" (

 curl --location "https://github.com/vaido-world/Download-D-Compiler-Windows-10/raw/main/windows10-download-dmd.cmd" -O
 call windows10-download-dmd.cmd

)


REM Ask for elevation of privilegies (Required only For Adding to PATH variable)
NET SESSION 1>NUL
IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE

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
MSHTA "javascript: new ActiveXObject('shell.application').ShellExecute('%~nx0', '', '', 'runas', 1); close();"
EXIT /B
