param (
    $path = ".",
    [System.EnvironmentVariableTarget] $scope = "User"
)

$varName = "PATH"
$userRootKey = [Microsoft.Win32.Registry]::CurrentUser
$userKeyName = "Environment"
$machineRootKey = [Microsoft.Win32.Registry]::LocalMachine
$machineKeyName = "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
($rootKey, $keyName) = switch ($scope)
{
    "User" { ($userRootKey, $userKeyName) }
    "Machine" { ($machineRootKey, $machineKeyName) }
}

$key = $rootKey.OpenSubKey($keyName, $true);
$options = [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames;
$oldValue = $key.GetValue($varName, "", $options);

$fullPath = [System.IO.Path]::GetFullPath($path)
$newValue = "$oldValue;$fullPath"

"Adding path '$fullPath' to environment variable $varName (scope $scope)..."
$valueKind = [Microsoft.Win32.RegistryValueKind]::ExpandString;
$key.SetValue($varName, $newValue, $valueKind);
"Path is successfully added to environment variable"
