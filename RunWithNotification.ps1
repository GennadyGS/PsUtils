if (!$args) {
    Write-Error "Command is not specified"
    exit 1
}

Function ReportError {
    param ($message)
    [Console]::ForegroundColor = 'red'
    [Console]::Error.WriteLine($message)
    [Console]::ResetColor()
    NotifyError $message
}

. $PSScriptRoot/Notifications.ps1

$commandText = [string]$args
$commandTextMessage = "'$commandText' in '$pwd'"
Write-Host "Running $commandTextMessage ..."
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
