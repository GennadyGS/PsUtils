param(
    [Parameter(mandatory=$true)] $path,
    [Parameter(mandatory=$true)] $destination,
    [switch] $override
)

If (!(Test-Path $path -PathType Container)) {
    throw "Source directory $path does not exist"
}

if ($override -and (Test-Path $destination) -and ((Get-Item $destination).LinkType -eq 'SymbolicLink')) {
    Remove-Item $destination
}

New-Item -Path $destination -ItemType SymbolicLink -Value $path