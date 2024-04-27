if (!$args) {
    Write-Error "Command is not specified"
    exit 1
}

. $PSScriptRoot\Common.ps1

$commandText = ArgumentsToCommandText $args
Write-Host "Running $commandText ..."
Invoke-Expression ". $commandText"
if ($LastExitCode -and $LastExitCode -ne 0) {
    $commandTextMessage = "'$commandText' in '$pwd'"
    Write-Error "$commandTextMessage has failed with code $LastExitCode"
    [System.Console]::ReadKey() | Out-Null
    exit $LastExitCode
}
