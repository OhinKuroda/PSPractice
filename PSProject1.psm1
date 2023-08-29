function Get-NewHires{
    <#
    .SYNOPSIS
        Import data from CSV data
    .DESCRIPTION
        Lets you import new hires from CSV and creates their security group and organizational unit if it is non-existant
    .NOTES
        You can edit the csv file path and Base ou path by using the following parameters
        Get-newhires -CsvFilePath "e:\NewHires.CSV",
        Get-newhires -BaseOU "DC=Adatum,dc=com"
    .LINK
        
    .EXAMPLE
        Get-newhires
    #>
     
    Param(
        $CsvFilePath = "e:\NewHires.CSV",
        $BaseOU = "DC=Adatum,dc=com"
    )  

    $NewHires = Import-Csv -Path $CsvFilePath

    foreach ($NewHire in $NewHires){
        $FirstName = $NewHire.firstname
        $LastName = $NewHire.lastName
        $Name = "$FirstName $LastName"
        $SamAccountName = $FirstName[0] + $LastName
        $Password = ConvertTo-SecureString -AsPlainText $NewHire.password -Force
        $department = $NewHire.Department
        $SecurityGroup = $NewHire.officename
        $OuPath = "OU=$Department,$BaseOU"

        if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $department})) {
        New-ADOrganizationalUnit -Name $department -Path $baseOU -Description "Department: $department"
        Write-Host "OU '$department' created."
        }

        if (-not (Get-ADGroup -Filter {Name -eq $SecurityGroup})) {
            New-ADGroup -Name $SecurityGroup -GroupScope Global
            Write-Host "ScurityGroup '$SecurityGroup' created."
        }

        New-ADUser -Name $Name -SamAccountName $SamAccountName -AccountPassword $Password -Path $OuPath
        Add-ADGroupMember -Identity $SecurityGroup -Members $SamAccountName

    }

}



function RestoreDeletedADUsers {
    <#
    .SYNOPSIS
        Restore Deleted Users to AD
    .DESCRIPTION
        Lists deleted Active Directory Users in the Recycle bin. Select the User from the menu and confirm restoration.
    .NOTES
        
    .LINK
        
    .EXAMPLE
        RestoreDeletedADUsers
        Are you sure you want to restore Jeannette Valentine
        DEL:3e9d44c3-b4bc-447d-80b2-eba2be52fcf0? (Y/N):
    #>
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