. $PSScriptRoot/Common.ps1
. $PSScriptRoot/Notifications.ps1
    
Function RunUntilFail {
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
    $commandText = ArgumentsToCommandText $args
    
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

Function ExtractPositionalArgs {
    Function IterationStep {
        param ($regularArgs, $inputArgs)
        if (!$inputArgs) {
            return $regularArgs + @("-positionalArgs", @())
        }
        $head, $tail = $inputArgs
        if ($head -eq "--") {
            return $regularArgs + @("-positionalArgs", $tail)
        }
        return ExtractPositionalArgs ($regularArgs + $head) $tail 
    }
    return IterationStep @() $args
}

$transformedArgs = ExtractPositionalArgs $args
RunUntilFail @transformedArgs