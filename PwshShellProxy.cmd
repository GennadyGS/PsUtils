@echo off
setlocal EnableExtensions EnableDelayedExpansion

if "%~1"=="" (
  echo Usage: %~n0 ^<script.ps1^> [args...]
  exit /b 64
)

rem The script path and the raw text of the remaining arguments are handed to PowerShell through
rem environment variables, so cmd neither splits arguments on = ; , nor alters their quotes, and the
rem path is invoked as a single-quoted literal (spaces, apostrophes, $ and ` in it are not code).
set "PWSH_PROXY_SCRIPT=%~f1"
set "PWSH_PROXY_ARGS=%*"
set "PWSH_PROXY_ARGS=!PWSH_PROXY_ARGS:*%1=!"

pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$global:LASTEXITCODE = 0; Invoke-Expression ('& ''{0}'' {1}' -f [Management.Automation.Language.CodeGeneration]::EscapeSingleQuotedStringContent($env:PWSH_PROXY_SCRIPT), $env:PWSH_PROXY_ARGS); $ok = $?; if ($LASTEXITCODE) { exit $LASTEXITCODE }; if (-not $ok) { exit 1 }"

exit /b %errorlevel%
