[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("01", "02", "03", "04", "05", "06")]
    [string]$Lesson,

    [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
    [string[]]$ProgramArguments = @()
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Get-Command java -ErrorAction SilentlyContinue) -or
    -not (Get-Command javac -ErrorAction SilentlyContinue)) {
    Write-Error "Java and javac are required. Run scripts\check-environment.cmd first."
    exit 1
}

$lessons = @{
    "01" = @("01-first-program", "org.ftc.training.lesson01.RobotStatus")
    "02" = @("02-variables-and-math", "org.ftc.training.lesson02.WheelCalculator")
    "03" = @("03-decisions-and-deadbands", "org.ftc.training.lesson03.JoystickControl")
    "04" = @("04-loops-and-autonomous", "org.ftc.training.lesson04.AutoSequence")
    "05" = @("05-methods-classes-and-tests", "org.ftc.training.lesson05.DriveMathTest")
    "06" = @("06-virtual-intake-project", "org.ftc.training.lesson06.VirtualIntakeControllerTest")
}

$lessonInfo = $lessons[$Lesson]
$repoDir = Split-Path -Parent $PSScriptRoot
$sourceDir = Join-Path $repoDir ("lessons\" + $lessonInfo[0] + "\src")
$buildDir = Join-Path $repoDir ("build\lesson-" + $Lesson)
$sourceFiles = @(Get-ChildItem -Path $sourceDir -Filter "*.java" -Recurse -File |
    ForEach-Object { $_.FullName })

if ($sourceFiles.Count -eq 0) {
    Write-Error "No Java source files found under $sourceDir"
    exit 1
}

New-Item -ItemType Directory -Path $buildDir -Force | Out-Null

& javac --release 8 -d $buildDir $sourceFiles
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

& java -cp $buildDir $lessonInfo[1] @ProgramArguments
exit $LASTEXITCODE
