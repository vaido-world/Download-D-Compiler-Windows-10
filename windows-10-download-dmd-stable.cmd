@ECHO OFF


REM Get the DMD compiler latest version number from Dlang website.
REM Example: 2.098.1
pushd "%TEMP%"
	curl "http://downloads.dlang.org/releases/LATEST" -O
	SET /P latest_dmd_version=<"%TEMP%\LATEST"
	DEL "%TEMP%\LATEST"
	ECHO DMD version: %latest_dmd_version% (as from downloads.dlang.org)
popd

REM Get the current date from google.com website http header.
REM Example: 2022
SETLOCAL EnableDelayedExpansion
FOR /F "tokens=* USEBACKQ skip=1 delims=" %%F IN (`curl -sI google.com`) DO (
	SET "http_response_header=%%F"
	if not "!http_response_header!"=="!http_response_header:date=!" (
		ECHO Manually extracting year from the date 
		SET "http_response_header_year=!http_response_header:~18,-13!"  
	) 
)
ECHO Today's year: %http_response_header_year% (as from google.com)


REM Checks if the current year http://downloads.dlang.org/releases/ has any DMD Compiler releases
REM Picks last year latest stable release if not
:Check_dlang_catalog_for_any_releases
for /f "tokens=*" %%a in ('curl -G "http://downloads.dlang.org/releases/%http_response_header_year%/" -s --write-out "%%{http_code}" --fail --output "output.txt"') do set httpcode=%%a
if %httpcode% == 404 SET /A http_response_header_year="%http_response_header_year% - 1" && GOTO :Check_dlang_catalog_for_any_releases
if %httpcode% == 403 SET /A http_response_header_year="%http_response_header_year% - 1" && GOTO :Check_dlang_catalog_for_any_releases

ECHO Last stable release of DMD Compiler is available from %http_response_header_year% year.
curl --ssl http://downloads.dlang.org/releases/%http_response_header_year%/dmd.%latest_dmd_version%.windows.zip -O
pause

