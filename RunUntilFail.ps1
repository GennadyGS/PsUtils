. $PSScriptRoot/Common.ps1
. $PSScriptRoot/Notifications.ps1

Function private:Implementation {
    param (
        $positionalArgs,
        $maxAttempts = 3,
        $successExitCode = 0,
        $timeoutSeconds = 2
    )

    if (!$positionalArgs) {
        Write-Error "Command is not specified"
        exit 1
    }
    $commandText = ArgumentsToCommandText $positionalArgs

    $attempt = 0
    Do {
        $attempt++
        "Attempt $attempt` of $maxAttempts to run command '$commandText'"
        $global:LastExitCode = 0
        Invoke-Expression ". $commandText"
        if ($global:LastExitCode -gt $successExitCode -or $global:LastExitCode -lt 0) {
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

$transformedArgs = ExtractPositionalArgs @args
private:Implementation @transformedArgs