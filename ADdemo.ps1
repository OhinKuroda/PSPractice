get-command *ADorg*

New-ADOrganizationalUnit -Name London -Path "DC=Adatum,dc=com"
Get-ADOrganizationalUnit -filter *
New-ADGroup -Name 'London Admins' -GroupScope Global
New-ADUser -name 'Ty Carlson' 
Add-ADGroupMember -Identity 'London Admins' -Members 'Ty Carlson'

Get-Adgroup -Filter "Name -eq 'London Admins'"
Get-aduser -Filter "name -eq 'Ty Carlson'" | Select-Object -Property *

New-ADComputer -name 'LON-CL2'

Move-ADObject -Identity "CN=London Admins,CN=Users,DC=Adatum,DC=com" -targetpath 'OU=London,DC=Adatum,DC=com'

$UsrToMove = Get-ADUser -Filter "name -eq 'Ty Carlson'"
$ObjtoMove = Get-ADComputer -Identity 'Lon-cl2'
$GrpToMove = Get-ADGroup -Identity 'London Admins'
$TgtPath = Get-ADOrganizationalUnit -Filter "Name -eq 'London'"
Move-ADObject -Identity $UsrToMove.DistinguishedName -TargetPath $TgtPath.DistinguishedName


Get-ADObject -SearchBase $TgtPath.DistinguishedName -filter *