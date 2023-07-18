if (!$args) {
    Write-Error "Command is not specified"
    exit 1
}

$commandText = [string]($args | ForEach-Object { $_.Contains(" ") ? "`"$_`"" : $_ })
Write-Host "Running $commandText ..."
Invoke-Expression $commandText
