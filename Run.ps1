if (!$args) {
    Write-Error "Command is not specified"
    exit 1
}

$commandText = [string]$args
Write-Host "Running $commandText ..."
Invoke-Expression $commandText
