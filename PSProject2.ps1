#prerequisite before starting project

#Install Recycle bin feature in AD
#Invoke-Command -ComputerName LON-DC1 -ScriptBlock {
#        $RecycleBin = Get-ADOptionalFeature 'Recycle Bin Feature'
#        if ($RecycleBin.EnabledScopes.Count -eq 0) {
#            Enable-ADOptionalFeature 'Recycle Bin Feature' -Scope ForestOrConfigurationSet -Target adatum.com -confirm:$false
#               }
#      }  

#Deletes 10 random users
#Invoke-Command -ComputerName LON-DC1 -ScriptBlock {  
#    Get-ADUser -Filter * -Properties Department | Where-Object {$_.Department -in @('Sales','Mareting','Managers')} | Get-Random -Count 10 | Remove-ADUser -Confirm:$false
#    }  
  
# # This command finds deleted objects
# Get-ADObject -LDAPFilter:"(msDS-LastKnownRDN=*)" -IncludeDeletedObjects | Where-Object {$_.Deleted -eq $true}

# # This command restores a deleted object 
# Restore-ADObject 

# This command can help produce a menu of choices
# Out-Gridview



function RestoreDeletedADUsers {
  param ()
  
  # This command finds deleted objects
$deletedUsers = Get-ADObject -LDAPFilter:"(msDS-LastKnownRDN=*)" -IncludeDeletedObjects | Where-Object {$_.Deleted -eq $true}

# Create a menu of choices
$menuItems = @()
foreach ($user in $deletedUsers) {
  $menuItem = New-Object PSObject -Property @{
      Name = $user.Name
      SamAccountName = $user.SamAccountName
      ObjectGUID = $user.ObjectGUID
  }
  $menuItems += $menuItem
}
# Display the menu using Out-GridView
$selectedUser = $menuItems | Out-GridView -Title "Select a deleted user to restore" -OutputMode Single

if ($selectedUser) {
  $confirmRestore = Read-Host "Are you sure you want to restore $($selectedUser.Name)? (Y/N)"
  if ($confirmRestore -eq "Y") {
  # This command restores a deleted object
    Restore-ADObject -Identity $selectedUser.ObjectGUID
    get-aduser -Identity $selectedUser.ObjectGUID -Properties deleted
    
  } else {
         Write-Host "Restoration of $($selectedUser.Name) canceled."
      }
} 
  
}

RestoreDeletedADUsers