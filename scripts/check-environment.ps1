[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Write-Error "Java was not found. Install JDK 17 or newer, reopen the terminal, and try again. See docs\windows-setup.md."
    exit 1
}

if (-not (Get-Command javac -ErrorAction SilentlyContinue)) {
    Write-Error "The Java compiler was not found. Install a full JDK, not only a JRE. See docs\windows-setup.md."
    exit 1
}

Write-Host "Java runtime:"
& java -version
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host ""
Write-Host "Java compiler:"
$compilerVersion = (& javac -version 2>&1 | Out-String).Trim()
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host $compilerVersion

$versionMatch = [regex]::Match($compilerVersion, "javac\s+(?:(1)\.)?(\d+)")
if (-not $versionMatch.Success) {
    Write-Error "Could not determine the javac version from: $compilerVersion"
    exit 1
}

if ($versionMatch.Groups[1].Success) {
    $majorVersion = [int]$versionMatch.Groups[2].Value
} else {
    $majorVersion = [int]$versionMatch.Groups[2].Value
}

if ($majorVersion -lt 17) {
    Write-Error "JDK 17 or newer is required for the current FTC SDK; found javac version $majorVersion. See docs\windows-setup.md."
    exit 1
}

Write-Host ""
Write-Host "Environment looks ready. Run: scripts\run-lesson.cmd 01"
