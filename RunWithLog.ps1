if (!$args) {
    Write-Error "Command is not specified"
    exit 1
}

. $PSScriptRoot\Common.ps1

filter timestamp { "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fff'): $_" }
$logDirectoryPath = Join-Path $PSScriptRoot Log
New-Item -ItemType Directory -Force -Path $logDirectoryPath | Out-Null
$logFileName = Join-Path $logDirectoryPath "$($args[0])_$(Get-Date -Format yyyyMMdd_HHmmss).log"

$commandText = ArgumentsToCommandText $args
Write-Host "Running $commandText ..."
Invoke-Expression ". $commandText" | timestamp | Tee-Object $logFileName