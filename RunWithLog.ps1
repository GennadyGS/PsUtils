param
(
    [Parameter(Mandatory=$true, Position=0)] $command,
    [Parameter(Mandatory=$false, Position=1, ValueFromRemainingArguments=$true)] $commandArgs
)
filter timestamp { "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fff'): $_" }
$logFileName = "$($command)_$(Get-Date -Format yyyyMMdd_HHmmss).log"
& $command $commandArgs | timestamp | Tee-Object $logFileName