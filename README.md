# NVidia-Shaders-Cleaner

A PowerShell script that removes ALL shader files (*.nvph) in the NVIDIA DXCache folder in Windows.

Title: DXCache NVidia Shaders Cleaner Script for NVidia GPUs
Version: 1.0
Filename: clear_nvidia_shaders.ps1

## Important Notes

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

Any PC games can then recreate the shaders (takes time) as needed
at game startup or otherwise.

## Requirements
The script MUST be `run as Administrator` in `PowerShell 7.5.2` or later to work
as intended.

## Usage

Read the above text and then CD into the correct directory and then to
run the script use:

`./clear_nvidia_shaders.ps1`
