param([String]$version="2.14.0",[String]$revision="2");

$ProgressPreference = "SilentlyContinue"

# Git version being bundled with this docker image.
if ($version -eq "") {
    $version = "2.14.0";
}

if ($revision -eq "") {
    $revision = "2";
}

if (-not($env:GIT_HOME)) {
    $env:GIT_HOME = "c:\\git";
    [Environment]::SetEnvironmentVariable("GIT_HOME", $env:GIT_HOME, "Machine");
}

New-Item -ItemType Directory -Force -Path "$env:GIT_HOME";

Write-Host "";
Write-Host "Downloading Git v$version to '$env:TEMP/git.exe'...";

$fileName = "Git-$version-64-bit.exe";

if (-not($revision -eq "1")) {
    $fileName = "Git-$version.$revision-64-bit.exe";
}

Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v$version.windows.$revision/$fileName" -OutFile "$env:TEMP/git.exe" -UseBasicParsing;

Write-Host "";
Write-Host "Download complete.";
Write-Host "";
Write-Host "Installing to '$env:GIT_HOME'...";

Start-Process -FilePath "$env:TEMP/git.exe" -ArgumentList "/VERYSILENT", "/NORESTART", "/NOCANCEL", "/SP-", "/DIR=$env:GIT_HOME" -PassThru | Wait-Process;
dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue;

Write-Host "";
Write-Host "Installation Complete.";