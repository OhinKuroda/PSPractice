#run before running script
# $SalesUsers = Get-ADUser -filter {Department -eq 'Sales'} -Properties Department
# $ADDisabledOU = if (-not (Test-Path 'AD:\OU=DisabledUsers,DC=Adatum,DC=com')) {New-ADOrganizationalUnit   -Path 'DC=adatum,DC=com' -Name DisabledUsers} 
# $UsersToDisable = $SalesUsers | Get-Random -Count 5
# $UsersToDisable | 
#    Select-Object -Property Name, Department | 
#       ConvertTo-Csv -NoTypeInformation |
#       Out-File e:\DisableList.csv -Force


function Disable-ADusers {
  param (
  )
  
  $UsersToDisable = Import-Csv -Path e:\DisableList.csv
  
  foreach ($UserToDisable in $UsersToDisable){
    $Username = $UsersToDisable.Name
    
  }
}