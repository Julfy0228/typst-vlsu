$sourceDir = $PSScriptRoot
$packageName = "vlsu-report"

# Read version from typst.toml
$tomlContent = Get-Content "$sourceDir\typst.toml" -Raw
if ($tomlContent -match 'version\s*=\s*"([^"]+)"') {
    $version = $matches[1]
} else {
    Write-Error "Cannot find version in typst.toml"
    exit 1
}

$dest = "$env:LOCALAPPDATA\typst\packages\local\$packageName\$version"

# Create destination directory
New-Item -ItemType Directory -Path $dest -Force | Out-Null

# Copy package files
$files = @(
    "lib.typ",
    "template.typ",
    "titlepage.typ",
    "appendix.typ",
    "drawing.typ",
    "typst.toml"
)

foreach ($file in $files) {
    Copy-Item -Path "$sourceDir\$file" -Destination $dest -Force
}

# Copy frame directory
Copy-Item -Path "$sourceDir\frame" -Destination $dest -Recurse -Force

Write-Host "Package $packageName v$version updated at $dest" -ForegroundColor Green
