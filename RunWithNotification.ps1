param
(
    [Parameter(Mandatory=$true, Position=0)] $command,
    [Parameter(Mandatory=$false, Position=1, ValueFromRemainingArguments=$true)] $commandArgs
)

Function ReportError {
    param ($message)
    [Console]::ForegroundColor = 'red'
    [Console]::Error.WriteLine($message)
    [Console]::ResetColor()
    NotifyError $message
}

. $PSScriptRoot/Notifications.ps1

$commandText = @($command) + $commandArgs | Join-String -Separator " "
$commandTextMessage = "'$commandText' in '$pwd'"
Write-Host "Running $commandText ..."
try {
    Invoke-Expression $commandText
    if ($LastExitCode -and $LastExitCode -ne 0) {
        ReportError "$commandTextMessage has failed with code $LastExitCode"
        exit $LastExitCode
    }
}
catch{
    ReportError "$commandTextMessage has failed with error $_"
    exit 1
}
NotifySuccess "'$commandText' in '$pwd' has succeeded"
