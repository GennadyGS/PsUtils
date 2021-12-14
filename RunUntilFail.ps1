param (
    [Parameter(Mandatory=$true)]$command,
    $maxAttempts = 3,
    $successExitCode = 0,
    $timeoutSeconds = 2
)

$attempt = 0
Do {
    $attempt++ 
    Write-Output "Attempt #$attempt to run command '$command'"
    Invoke-Expression $command
    if ($LastExitCode -gt $successExitCode) {
        Write-Warning "Attempt #$attempt of command '$command' is finished with error exit code $LastExitCode"
        Break
    }
    "Command is finished with success exit code $LastExitCode"
    if ($attempt -ge $maxAttempts) {
        Write-Output "All $attempt attempts of command '$command' have passed"
        Break
    } else {
        Write-Warning "Retry to run command after $timeoutSeconds s"
        Start-Sleep -s $timeoutSeconds
    }
} While(True)
