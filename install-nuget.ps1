param([String]$path="c:/nuget");

$ProgressPreference = "SilentlyContinue";

if ($path -eq "") {
    $path = "c:/nuget";
}

if (-not($env:NUGET_HOME)) {
    $env:NUGET_HOME = $path;
    [Environment]::SetEnvironmentVariable("NUGET_HOME", $env:NUGET_HOME, "Machine");
}

New-Item -ItemType Directory -Force -Path $path;

Write-Host "";
Write-Host "Downloading NuGet to '$path'...";

Invoke-WebRequest "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile "$path/nuget.exe" -UseBasicParsing;

Write-Host "";
Write-Host "Download complete.";