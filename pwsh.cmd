@ECHO OFF
SET args=%*
pwsh.exe -noLogo -ExecutionPolicy unrestricted -command "%args:"='%"