Invoke-Command -Computername lon-svr1 -ScriptBlock {
  Get-WindowsFeature 
} | Select-Object Name, InstallState

Invoke-Command -ComputerName lon-svr1 -ScriptBlock {
  Install-WindowsFeature -name Web-Server
}

$DC1Session = New-PSSession -ComputerName lon-dc1

get-command *smbshare
Get-SmbShare

$DC1Session = New-PSSession -ComputerName lon-dc1
import-module -Prefix DC1 -name SmbShare -PSsession $DC1Session

Get-DC1SmbShare