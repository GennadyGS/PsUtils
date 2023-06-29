param (
    $path = ".",
    [System.EnvironmentVariableTarget] $scope = "User"
)

$varName = "PATH"
$fullPath = [System.IO.Path]::GetFullPath($path)
$oldValue = [Environment]::GetEnvironmentVariable($varName, $scope)
$newValue = "$oldValue;$fullPath"
"Adding path '$fullPath' to environment variable $varName (scope $scope)..."
[Environment]::SetEnvironmentVariable($varName, $newValue, $scope)
"Path is successfully added to environment variable"
