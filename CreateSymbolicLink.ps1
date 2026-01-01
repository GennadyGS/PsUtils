param(
    [Parameter(Mandatory)] $path,
    [Parameter(Mandatory)] $destination,
    [switch] $override
)

If (!(Test-Path $path -PathType Container)) {
    throw "Source directory $path does not exist"
}

if ($override -and
    (Test-Path $destination) -and
    ((Get-Item $destination).LinkType -in ('SymbolicLink', 'Junction')))
{
    Remove-Item $destination
}

New-Item -Path $destination -ItemType SymbolicLink -Value $path