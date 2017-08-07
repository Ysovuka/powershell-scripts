param([String]$version="15")

$ProgressPreference = "SilentlyContinue";

if ($version -eq "") {
    $version = "15";
}

Write-Host "";
Write-Host "Downloading MSBuild v$version...";

if ($version -eq "15"){
    Invoke-WebRequest "https://aka.ms/vs/$version/release/vs_BuildTools.exe" -OutFile "$env:TEMP/vs_BuildTools.exe" -UseBasicParsing;
}
elseif ($version -eq "14") {
    Invoke-WebRequest "https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe" -OutFile "$env:TEMP\BuildTools_Full.exe" -UseBasicParsing;
}
elseif ($version -eq "12") {
    Invoke-WebRequest "https://download.microsoft.com/download/9/B/B/9BB1309E-1A8F-4A47-A6C5-ECF76672A3B3/BuildTools_Full.exe" -OutFile "$env:TEMP\BuildTools_Full.exe" -UseBasicParsing;
}

Write-Host "";
Write-Host "Download complete.";

Write-Host "";
Write-Host "Installing MSBuild Tools...";

if ($version -eq "15") {
    Start-Process -FilePath "$env:TEMP/vs_BuildTools.exe" -ArgumentList "--quiet", "--passive", "--norestart", "--all", "--includeRecommended" -PassThru | Wait-Process;
}
else {
    Start-Process -FilePath "$env:TEMP\BuildTools_Full.exe" -ArgumentList '/Passive', '/NoRestart' -PassThru | Wait-Process;
}

dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue;

Write-Host "";
Write-Host "Installation complete.";