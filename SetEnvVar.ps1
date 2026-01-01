param (
    [Parameter(Mandatory)] $name,
    [Parameter(Mandatory)] $value,
    [System.EnvironmentVariableTarget] $scope = "User"
)

[Environment]::SetEnvironmentVariable($name, $value, $scope)
"Environment variable $varName (scope $scope) is set to '$value'"