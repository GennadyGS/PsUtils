param
(
    [Parameter(Mandatory=$true, Position=0)] $command,
    [Parameter(Mandatory=$false, Position=1, ValueFromRemainingArguments=$true)] $commandArgs
)
$commandText = @($command) + $commandArgs | Join-String -Separator " "
Write-Host "Running $commandText ..."
Invoke-Expression $commandText
