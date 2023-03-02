param (
    [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)] $command,
    $maxAttempts = 3,
    $successExitCode = 0,
    $timeoutSeconds = 2
)

. $PSScriptRoot/Notifications.ps1

$commandText = [string]$command
"Command: $commandText"

$attempt = 0
Do {
    $attempt++
    "Attempt $attempt of $maxAttempts to run command '$commandText'"
    Invoke-Expression $commandText
    if ($LastExitCode -gt $successExitCode) {
        $message =
            "Attempt $attempt of $maxAttempts of command '$commandText' " +
            "is finished with error exit code $LastExitCode"
        Write-Warning $message
        NotifyWarning $message
        Exit $LastExitCode
    }
    "Attempt $attempt of $maxAttempts is finished with success exit code $LastExitCode"
    if ($attempt -ge $maxAttempts) {
        $message = "All $attempt attempts of command '$commandText' have passed"
        NotifySuccess $message
        Break
    } else {
        "Retrying to run command after $timeoutSeconds s"
        Start-Sleep -s $timeoutSeconds
    }
} While($True)
