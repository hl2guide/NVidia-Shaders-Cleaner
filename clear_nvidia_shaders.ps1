<#

Title: DXCache NVidia Shaders Cleaner Script for NVidia GPUs
Version: 1.0
Filename: clear_nvidia_shaders.ps1

IMPORTANT NOTES:

This script applies to a user of NVidia GPUs and does nothing at all
for AMD or Intel GPUs.

NVIDIA Shaders can become corrupted or invalid and need to be rebuilt
by a game or app.

This script removes ALL shader files (*.nvph) in the NVIDIA DXCache folder:
$env:LOCALAPPDATA\NVIDIA\DXCache

Before running this script check that all PC games and apps that use your
NVidia GPU (hardware acceleration) are closed off and not open and running.
This includes the NVidia App and related processes in the
taskbar (bottom right on Windows desktop).

This script will remove ALL shader files (*.nvph) in the folder:
$env:LOCALAPPDATA\NVIDIA\DXCache, if they are not in use.

Any PC games can then recreate the shaders (takes time) as needed
at startup or otherwise.

The script MUST be "run as Administrator" in PowerShell 7.5.2 or later to work
as intended.

USAGE:

Read the above text and then CD into the correct directory and then to
run the script use:
./clear_nvidia_shaders.ps1

#>

# Checks if the user has administrative privileges and if not it exits the script
$message = "This script requires administrative privileges. Exiting now..."
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host $message -ForegroundColor Red
    exit
}
else {
    $message = "Running this script as Administrator."
    Write-Host
    Write-Host $message -ForegroundColor Cyan
}

# Shows intro header message
Write-Host
$messasge = "DXCache NVidia Shaders Cleaner Script for NVidia GPUs"
Write-Host $messasge -ForegroundColor White -BackgroundColor DarkMagenta
$messasge = "Version: 1.0"
Write-Host $messasge -ForegroundColor Magenta

Write-Host

$messasge = "This PowerShell script will remove ALL shader files (*.nvph) in the NVIDIA DXCache" +
" folder:`n$env:LOCALAPPDATA\NVIDIA\DXCache"
Write-Host $messasge -ForegroundColor White

Write-Host

$messasge = "Please close off all Nvidia GPU related apps and games before continuing."
Write-Host $messasge -ForegroundColor Blue

Write-Host

pause

Write-Host

# Prompts user to confirm action
$message = "Do you want to delete all NVIDIA shader files in the following folder?"
Write-Host $message -ForegroundColor White
$message = "$env:LOCALAPPDATA\NVIDIA\DXCache"
Write-Host $message -ForegroundColor Magenta
$message = "(Y/N)"
$response = Read-Host $message
if ($response -match '^(yes|y)$') {
    # Write-Host "✅ Proceeding..."
}
elseif ($response -match '^(no|n)$') {
    $message = "✋ Script halted. Exited."
    Write-Host $message -ForegroundColor White
    exit
}
else {
    $message = "⚠️ Invalid response. Please enter Y or N."
    Write-Host $message -ForegroundColor Yellow
}

Write-Host

# Starts the removal process

$nvCachePath = "$env:LOCALAPPDATA\NVIDIA\DXCache"
#$nvCachePath

if (Test-Path $nvCachePath) {
    $nvphFiles = Get-ChildItem -Path $nvCachePath -Filter *.nvph -File
    if ($nvphFiles.Count -gt 0) {
        try {
            $nvphFiles | Remove-Item -Force
            $message = "✅ Deleted .nvph shader files from NVIDIA DXCache folder ($nvCachePath)."
            Write-Host $message -ForegroundColor Green
        }
        catch {
            $message = "🛑 An error(s) happened while deleting .nvph files: $_"
            Write-Host $message -ForegroundColor Red
        }
    }
    else {
        $message = "ℹ️ No .nvph files were found in the NVIDIA DXCache folder ($nvCachePath)."
        Write-Host $message -ForegroundColor Blue
    }
}
else {
    $message = "⚠️ NVIDIA DXCache folder ($nvCachePath) was not found."
    Write-Host $message -ForegroundColor Yellow
}

# Shows exit message
Write-Host
$message = "Done 👍 Please note that it is to be expected that some shaders may " +
"be unable to be deleted."
Write-Host $message -ForegroundColor Green

exit