<#
.Synopsis
Install the DameWare Mini Remote Control service on a remote machine.
.Description
Install the DameWare Mini Remote Control service on a remote machine.
.Parameter ComputerName
Set a remote machine name to install to.
.Notes
Create the msi file through the DameWare program and save to your C:\Temp\ folder.
#>
function Install-Dameware {
[cmdletbinding()]
param(
	[Parameter()]
	[string]$ComputerName=$(Read-Host -prompt "Enter Remote System Number")
)
Process {
Write-Host "Copying file"
copy-item -path C:\userdata\Dameware.MSI -Destination \\$ComputerName\c$\temp\Dameware.msi
Write-Host "Installing service"
invoke-command -ComputerName $ComputerName -ScriptBlock {start -FilePath "c:\temp\dameware.msi" -ArgumentList "/qn" -wait}
Write-Host "Pausing for 15 seconds"
Start-Sleep -Seconds 15
Write-Host "Checking service"
$Test = invoke-command -ComputerName $ComputerName -ScriptBlock {(Get-Service dwmrcs).Status}
IF ($Test -eq "Running") {
Write-Host "Dameware installed"
}
Else {
Write-Warning "Dameware install failed or pending"
$Check = Read-Host "Check for service again? Y or N"
    IF ($Check -eq "Y" -OR $Check -eq "Yes")
        Write-Host "Pausing for 15 seconds"
        Start-Sleep -Seconds 15
        Write-Host "Checking service"
        Invoke-command -ComputerName $ComputerName -ScriptBlock {(Get-Service dwmrcs).Status}
    Else {}
}
}}
