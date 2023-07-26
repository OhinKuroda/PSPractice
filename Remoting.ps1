Enter-PSSession -ComputerName lon-svr1
#Enters a one-to-one remote session
Get-ComputerInfo
Exit-PSSession


Invoke-Command -ComputerName lon-svr1,lon-dc1 -ScriptBlock {Get-service -name Spooler}
#sends a command to mutiple computers
#you can specify a local file and have it run on multiple machines
#each invoke command creates its own shell

Invoke-Command -ScriptBlock { Do-Something $Using:variable } -ComputerName REMOTE
$ps = "Windows PowerShell" 
Invoke-Command -ComputerName LON-DC1 -ScriptBlock {Get-WinEvent -LogName $Using:ps}
#using takes a local variable and sends it to the remote machine


$Sessions = New-PSSession -ComputerName lon-dc1,lon-svr1
Invoke-Command -ScriptBlock {hostname} -session $Sessions
#can store yours sessions in a variable

$DC = New-PSSession -ComputerName lon-dc1
Import-Module NetSecurity
Get-Command -Module NetSecurity
Import-Module -Prefix DC -Name NetSecurity -PSSession $DC
get-module
Get-DCNetFirewallRule | Select-Object -First 3 -Property name,PscomputerName
Get-NetFirewallRule | Select-Object -First 3 -Property name,PscomputerName
#imported module from the DC session and added the DC prefix to the commands
#implicit remoting lets you run commands on remote machine wihtout a specifying remote connection
#if you didnt have the moduls on your local machine to be able to make changes on the dc 
#you could pull the module from the dc. Ghost commands to run on the remote machine

Get-PSSession | Remove-PSSession

get-module | select-object name,PrivateData 
(get-module).PrivateData

Get-Module | 
Where-Object {$_.PrivateData} |
Where-Object {$_.PrivateData.ContainsKey('ImplicitRemoting')} 
#how to find your implicit remoting modules useful for fixing mistakes if you didnt set your prefix

