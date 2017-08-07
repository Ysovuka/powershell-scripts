param([String]$version="2017.1.20170613.162720",[string]$path="c:/jetbrains-commandline-tools");

$ProgressPreference = "SilentlyContinue";

# JETBRAINS_CLT version being bundled in this docker image.
if ($path -eq "") {
    $path = "c:/jetbrains-commandline-tools";
}

New-Item -ItemType Directory -Force -Path "$path";
cd "$env:TEMP";

$fileVersion = " -Version $version";
if ($version -eq "") {
    $fileVersion = "";
}

Write-Host "";
if ($version -eq "") {
    Write-Host "Installing JetBrains Resharper Command Line Tools to '$path'...";
}
else {
    Write-Host "Installing JetBrains Resharper Command Line Tools v$version to '$path'...";
}

Start-Process "$env:NUGET_HOME/nuget.exe" -ArgumentList "Install JetBrains.ReSharper.CommandLineTools $fileVersion" -PassThru | Wait-Process;
$tempPath = (Get-Item -Path "JetBrains.*").FullName;
mv "$tempPath/tools/*" "$path";
#dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue;
#cd /;

Write-Host "";
Write-Host "Installation complete.";