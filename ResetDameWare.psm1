<#
.Synopsis
Used to reset the DameWare service on a remote machine.
.Description
Used to reset the DameWare service on a remote machine.
.Parameter ComputerName
Set a remote machine name to reset the DameWare service on.
.Notes
None.
#>
function Reset-Dameware {
[cmdletbinding()]
param(
	[Parameter()]
	[string[]]$ComputerName=$(Read-Host -Prompt "Enter Remote System Number(s)")
)
Process{
Write-Host "Restarting the DameWare Service on $ComputerName"
invoke-command -ComputerName $ComputerName -ScriptBlock {restart-service dwmrcs -PassThru}
			if($?){
			Write-Host "Command Succeeded."
			}
			else{
			Write-Warning "Command Failed."}
        Write-Host "DameWare Reset Complete."
		}}
