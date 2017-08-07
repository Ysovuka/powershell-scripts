param([String]$version="6.11.2");

$ProgressPreference = "SilentlyContinue";

# Node.js version being bundled in this docker image.
if ($version -eq "") {
    $version = "6.11.2";
}

Write-Host "";
Write-Host "Downloading Node.js v$version...";

Invoke-WebRequest "https://nodejs.org/dist/v$version/node-v$version-x64.msi" -OutFile "$env:TEMP/nodejs.msi" -UseBasicParsing;

Write-Host "";
Write-Host "Download complete.";

Write-Host "";
Write-Host "Installing Node.js...";

Start-Process -FilePath "$env:TEMP/nodejs.msi" -ArgumentList "/quiet", "/norestart" -PassThru | Wait-Process;
dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue;

Write-Host "";
Write-Host "Installation complete.";