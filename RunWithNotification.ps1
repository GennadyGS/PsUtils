[CmdletBinding(PositionalBinding = $false)]
param (
    [Parameter(Mandatory, Position = 0)] $ScriptName,
    [Parameter(ValueFromRemainingArguments)] [string[]] $RemainingArgs
)

Function ReportError {
    param ($message)
    [Console]::ForegroundColor = 'red'
    [Console]::Error.WriteLine($message)
    [Console]::ResetColor()
    NotifyError $message
}

. $PSScriptRoot/Notifications.ps1

$commandText = "$ScriptName $RemainingArgs"
$commandTextMessage = "'$commandText' in '$pwd'"
Write-Host "Running $commandTextMessage ..."
try {
    $global:LastExitCode = 0
    & $ScriptName $RemainingArgs
    if ($global:LastExitCode -and $global:LastExitCode -ne 0) {
        ReportError "$commandTextMessage has failed with code $global:LastExitCode"
        exit $global:LastExitCode
    }
}
catch{
    ReportError "$commandTextMessage has failed with error $_"
    exit 1
}
NotifySuccess "$commandTextMessage has succeeded"
