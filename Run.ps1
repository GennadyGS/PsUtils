if (!$args) {
    Write-Error "Command is not specified"
    exit 1
}
"args.Count: $($args.Count)"
$i = 0
$args | ForEach-Object { "$($i): '$_'"; $i++ }
"args: '$args'"

$commandText = [string]($args | ForEach-Object { "'$_'" })
Write-Host "Running $commandText ..."
Invoke-Expression ". $commandText"
