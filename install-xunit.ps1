param([String]$version = "2.2.0",[String]$path="c:/xunit");
$ProgressPreference = "SilentlyContinue";

# xUnit version being bundled in this docker image.
if ($version -eq "") {
    $version = "2.2.0";
}

if ($path -eq "") {
    $path = "c:/xunit";
}

New-Item -ItemType Directory -Force -Path "$path";
cd "$env:TEMP";

Write-Host "";
Write-Host "Installing xUnit v$version to '$path'...";

Start-Process "$env:NUGET_HOME/nuget.exe" -ArgumentList "Install xunit.runner.console -Version $version" -PassThru | Wait-Process;
mv "$env:TEMP/xunit.runner.console.$version/tools/*" "$path";
dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue;
cd /;

Write-Host "";
Write-Host "Installation complete.";