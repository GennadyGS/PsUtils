. $PSScriptRoot\Common.ps1

$commandText = ArgumentsToCommandText $args
Get-ChildItem -Directory `
| ForEach-Object {
    Write-Host "$_>" -NoNewLine -ForegroundColor darkYellow
    Push-Location $_
    Invoke-Expression ". $PSScriptRoot\Run.ps1 $commandText"
    Pop-Location
}
