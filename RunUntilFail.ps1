. $PSScriptRoot/Notifications.ps1
    
Function RunUntilFail {
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)] $command,
        $maxAttempts = 3,
        $successExitCode = 0,
        $timeoutSeconds = 2
    )

    $commandText = [string]$command
    if (!$commandText) {
        Write-Error "Command is not specified"
        exit 1
    }
    "Command: $commandText"
    
    $attempt = 0
    Do {
        $attempt++
        "Attempt $attempt` of $maxAttempts to run command '$commandText'"
        $global:LastExitCode = 0
        Invoke-Expression $commandText
        if ($global:LastExitCode -gt $successExitCode) {
            $message =
                "Attempt $attempt of $maxAttempts of command '$commandText' " +
                "is finished with error exit code $global:LastExitCode"
            Write-Warning $message
            NotifyWarning $message
            Exit $global:LastExitCode
        }
        "Attempt $attempt of $maxAttempts is finished with success exit code $global:LastExitCode"
        if ($attempt -ge $maxAttempts) {
            $message = "All $attempt attempts of command '$commandText' have passed"
            NotifySuccess $message
            Break
        } else {
            "Retrying to run command after $timeoutSeconds s"
            Start-Sleep -s $timeoutSeconds
        }
    } While($True)    
}

RunUntilFail @args