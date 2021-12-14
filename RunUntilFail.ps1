param (
    [Parameter(Mandatory=$true)]$command,
    $maxAttempts = 3,
    $successExitCode = 0,
    $timeoutSeconds = 2
)

$attempt = 0
Do {
    $attempt++ 
    Write-Output "Attempt $attempt of $maxAttempts to run command '$command'"
    Invoke-Expression $command
    if ($LastExitCode -gt $successExitCode) {
        Write-Warning "Attempt $attempt of $maxAttempts of command '$command' is finished with error exit code $LastExitCode"
        Break
    }
    "Attempt $attempt of $maxAttempts is finished with success exit code $LastExitCode"
    if ($attempt -ge $maxAttempts) {
        Write-Output "All $attempt attempts of command '$command' have passed"
        Break
    } else {
        Write-Output "Retrying to run command after $timeoutSeconds s"
        Start-Sleep -s $timeoutSeconds
    }
} While($True)