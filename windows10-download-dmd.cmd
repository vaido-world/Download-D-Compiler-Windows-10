@ECHO OFF


ECHO _____________Extracting .zip file_____________
mkdir "./7za/"
curl "https://www.7-zip.org/a/7za920.zip" -O
move "7za920.zip" "./7za/"
tar -xf "./7za/7za920.zip" -C "./7za/"


ECHO _____________Downloading D language Compiler_____________
curl "https://s3.us-west-2.amazonaws.com/downloads.dlang.org/releases/2021/dmd.2.098.0.windows.7z" --ssl -L -O

ECHO Extracting .7z file
"./7za/7za.exe" "x" "./dmd.2.098.0.windows.7z"

ECHO Testing D compiler
".\dmd2\windows\bin\dmd.exe" --version
".\dmd2\windows\bin64\dmd.exe" --version

ECHO Adding to PATH variable
curl -L "https://github.com/vaido-world/Download-D-Compiler-Windows-10/raw/main/add_to_path.cmd" -O
move "./add_to_path.cmd" "./dmd2/windows/bin/"
"./dmd2/windows/bin/add_to_path.cmd"
