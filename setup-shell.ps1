Write-Host "Git: add customisations"
& git config --global include.path $pwd\git\.gitconfig

Write-Host "Powershell: get modules"
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module `
    -Name @('Terminal-Icons') `
    -Repository PSGallery

Install-Module PSReadLine -RequiredVersion 2.1.0

Write-Host  "Windows Terminal: Updating PWSH profile"
$runCmd = ". `"$pwd\\pwsh\\run.ps1`"";
If((Select-String -Path $PROFILE -Pattern $runCmd -SimpleMatch).Length -eq 0)
{
    Write-Host 'Adding bootstrap script to $PROFILE'
    Add-Content -Path $PROFILE -Value $([Environment]::NewLine) -NoNewline
    Add-Content -Path $PROFILE -Value $runCmd
}

# replace font in Windows Terminal
Write-Host "Windows Terminal: Setting Nerd Font"
Install-Module -Name MSTerminalSettings -AllowPrerelease
Get-MSTerminalProfile | Set-MSTerminalProfile -FontFace "CaskaydiaCove Nerd Font"
