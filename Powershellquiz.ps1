#must be done in ISE

#Q1.1
Get-Service | Select-Object -Property Status,StartType,Name,DisplayName

#G1.2
Get-Help -showwindow Get-CimInstance
Get-CimClass | Where-Object CimClassName -Like *bios*
Get-CimInstance -ClassName Win32_BIOS | Select-Object -Property BIOSVersion,ReleaseDate

#Q1.3
Get-EventLog 
Get-EventLog -LogName System -Newest 4| Select-Object -Property EventID,@{n='MinutesAgo';e={((Get-Date) - $_.TimeGenerated).Minutes}}