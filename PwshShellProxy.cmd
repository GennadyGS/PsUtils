@echo off
setlocal EnableExtensions EnableDelayedExpansion

if "%~1"=="" (
  echo Usage: %~n0 ^<script.ps1^> [args...]
  exit /b 64
)

set "SCRIPT=%~f1"
shift

set "ARGS="

:loop
if "%~1"=="" goto run

set "ARG=%~1"
set "ARG=!ARG:"=""!"

set "ARGQ=%1"
set "ARGU=%~1"
if "%ARGQ:"=#%" NEQ "%ARGU:"=#%" set "ARG="""!ARG!""""

set "ARGS=!ARGS! !ARG!"

shift
goto loop

:run
pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "%SCRIPT%" %ARGS%

exit /b %errorlevel%
