param([String]$version="3.7.1",[String]$path="c:/nunit");

$ProgressPreference = "SilentlyContinue";

# nUnit version being bundled in this docker image.
if ($version -eq "") {
    $version = "3.7.1";
}

if ($path -eq "") {
    $path = "c:/nunit";
}

New-Item -ItemType Directory -Force -Path "$path";

Write-Host "";
Write-Host "Downloading nUnit v$version to '$path'...";

Invoke-WebRequest "https://github.com/nunit/nunit/archive/$version.zip" -OutFile "$env:TEMP/nunit.zip" -UseBasicParsing;
Expand-Archive "$env:TEMP/nunit.zip" -DestinationPath "$path" -Force;
dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue;

Write-Host "";
Write-Host "Download complete.";