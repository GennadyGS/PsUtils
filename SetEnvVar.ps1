param (
    [Parameter(mandatory=$true)] $name,
    [Parameter(mandatory=$true)] $value,
    [System.EnvironmentVariableTarget] $scope = "User"
)

[Environment]::SetEnvironmentVariable($name, $value, $scope)
"Environment variable $varName (scope $scope) is set to '$value'"