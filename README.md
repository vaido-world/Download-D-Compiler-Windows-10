# Download-D-Compiler-Windows-10
[Automation] Batch script that downloads, extracts and launches D Compiler on Windows 10 or Windows 11

### Quick launch 
`curl --location "https://github.com/vaido-world/Download-D-Compiler-Windows-10/raw/main/windows10-download-dmd.cmd" | cmd`

This is not a DMD compiler installer.  
But probably will do the same things in the future.  

The reason of the project:  
The original installer of DMD does not support command line options.     
I've got tired of clicking through the installer's wizard buttons.  
Note: The original installer is little more than an archive extraction.  


~~This script does not add the compiler to PATH environment variable.~~  
`add_to_path.cmd` can be used to add a folder to PATH.  (Requires Administrator Privilegies)  
Has been partly integrated with the main script as well.  

This project is here to provide DMD Compiler on Windows 10 and 11 operating systems flawlessly.  

---

**Default installation location:** `%SystemDrive%:\D\`  
Example: `C:\D\dmd2\windows\bin\dmd.exe`

**Note:** Command Prompts in a Windows operating systems are programmed to take the PATH environment  
variable only at the instance's launch. Please restart your existing command prompt instances to take affect.



---
References:The official Dlang installer https://github.com/dlang/installer/blob/7b71542a59b6ae095fc867d4e6eb5e8b6a04573a/windows/EnvVarUpdate.nsh

