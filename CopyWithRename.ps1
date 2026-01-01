param(
    [Parameter(Mandatory)] $path,
    [Parameter(Mandatory)] $destination
)

Function FindUniqueFileName($fileName) {
    $result = $fileName
    $i = 0
    While (Test-Path $result -PathType Leaf) {
        $i += 1
        $parentPath = Split-Path $fileName -Parent
        $fileNameBase = Split-Path $fileName -LeafBase
        $extension = Split-Path $fileName -Extension
        $establishedFileName = $fileNameBase + " ($i)" + $extension
        $result = Join-Path $parentPath $establishedFileName
    }
    return $result
}

If (!(Test-Path $path -PathType Leaf)) {
    throw "Source file $path does not exist"
}

$destinationFileName = (Test-Path $destination -PathType Container) `
    ? (Join-Path $destination (Split-Path $path -Leaf))
    : $destination

$uniqueFileName = FindUniqueFileName $destinationFileName

Copy-Item -Path $path -Destination $uniqueFileName -Force