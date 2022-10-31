param (
    $path = ".",
    [System.EnvironmentVariableTarget] $scope = "User"
)

$varName = "PATH"
$fullPath = [System.IO.Path]::GetFullPath($path)
$oldValue = [Environment]::GetEnvironmentVariable($varName, $scope)
$newValue = "$oldValue;$fullPath"
[Environment]::SetEnvironmentVariable($varName, $newValue, $scope)
"Path '$fullPath' is added to environment variable $varName (scope $scope)"