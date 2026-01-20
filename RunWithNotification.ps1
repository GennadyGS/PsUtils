[CmdletBinding(PositionalBinding = $false)]
param (
    [Parameter(Mandatory, Position = 0)] $ScriptName,
    [Parameter(ValueFromRemainingArguments)] [object[]] $RemainingArgs
)

Function ReportError {
    param ($message)
    [Console]::ForegroundColor = 'red'
    [Console]::Error.WriteLine($message)
    [Console]::ResetColor()
    NotifyError $message
}

. $PSScriptRoot/Common.ps1
. $PSScriptRoot/Notifications.ps1

"ScriptName: $ScriptName"
"RemainingArgs:"
$RemainingArgs

$commandText = "$ScriptName $RemainingArgs"
$commandTextMessage = "'$commandText' in '$pwd'"
Write-Host "Running $commandTextMessage ..."
try {
    $global:LastExitCode = 0
    $FullScriptPath = Resolve-FullScriptPath $ScriptName
    $QuotedArgs = $RemainingArgs | ForEach-Object { $_ -eq "-p" ? "`"$_`"" : $_ }
    & cmd /c pwshShellProxy.cmd $FullScriptPath @QuotedArgs
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
