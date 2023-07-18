if (!$args) {
    Write-Error "Command is not specified"
    exit 1
}

. $PSScriptRoot\Common.ps1

$commandText = ArgumentsToCommandText $args
Write-Host "Running $commandText ..."
Invoke-Expression $commandText
