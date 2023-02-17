param
(
    [Parameter(Mandatory=$true, Position=0)] $command,
    [Parameter(Mandatory=$false, Position=1, ValueFromRemainingArguments=$true)] $commandArgs
)
filter timestamp { "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fff'): $_" }
$logDirectoryPath = Join-Path $PSScriptRoot Log
New-Item -ItemType Directory -Force -Path $logDirectoryPath | Out-Null
$logFileName = Join-Path $logDirectoryPath "$($command)_$(Get-Date -Format yyyyMMdd_HHmmss).log"

$commandText = @($command) + $commandArgs | Join-String -Separator " "
Write-Host "Running $commandText ..."
. $command $commandArgs | timestamp | Tee-Object $logFileName