param (
    $path = ".",
    [System.EnvironmentVariableTarget] $scope = "User"
)

$varName = "PATH"
$fullPath = [System.IO.Path]::GetFullPath($path)
$oldValue = [Environment]::GetEnvironmentVariable($varName, $scope)
$newValue = "$oldValue;$fullPath"
"Adding path '$fullPath' to environment variable $varName (scope $scope)..."
$job = Start-Job `
    -ScriptBlock {
        param ($varName, $newValue, $scope)
        [Environment]::SetEnvironmentVariable($varName, $newValue, $scope)
    } -ArgumentList $varName, $newValue, $scope
$job | Wait-Job -Timeout 5
If ($job.State -eq [Management.Automation.JobState]::Completed) {
    "Path is successfully added to environment variable"
}
Else {
    Write-Error "Job is not completed successfully and has state $($job.State)"
    Remove-Job $job -Force
}