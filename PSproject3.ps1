
# #run this before tryint the script
# # Create OU
# New-ADOrganizationalUnit -Name AdatumGroups -Path 'DC=adatum,DC=com' -ErrorAction SilentlyContinue

# # Global groups
# New-ADGroup -Name SalesAdmin -GroupScope Global  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
# New-ADGroup -Name MktgAdmin -GroupScope Global  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
# New-ADGroup -Name DevAdmin -GroupScope Global  -Path 'ou=AdatumGroups,dc=adatum,dc=com'

# # Universal groups
# New-ADGroup -Name AllAdmin -GroupScope Universal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'

# # Domain Local groups
# New-ADGroup -Name ColorPtr -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
# New-ADGroup -Name SalesDB -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
# New-ADGroup -Name MktgData -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
# New-ADGroup -Name CommonData -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
# New-ADGroup -Name BWPtr -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
# New-ADGroup -Name CustomerDB -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'
# New-ADGroup -Name AllowRemote -GroupScope DomainLocal  -Path 'ou=AdatumGroups,dc=adatum,dc=com'

# # Nesting groups
# Add-ADGroupMember -Identity ColorPtr -Members (Get-ADGroup -Filter {Name -eq 'MktgAdmin'})
# Add-ADGroupMember -Identity SalesDB -Members (Get-ADGroup -Filter * | Where-Object {$_.Name -in ('SalesAdmin','MktgAdmin')})
# Add-ADGroupMember -Identity MktgData -Members (Get-ADGroup -Filter {Name -eq 'MktgAdmin'})
# Add-ADGroupMember -Identity CommonData -Members (Get-ADGroup -Filter {Name -eq 'AllAdmin'})
# Add-ADGroupMember -Identity BWPtr -Members (Get-ADGroup -Filter {Name -eq 'AllAdmin'})
# Add-ADGroupMember -Identity CustomerDB -Members (Get-ADGroup -Filter * | Where-Object {$_.Name -in ('SalesAdmin','DevAdmin')})
# Add-ADGroupMember -Identity AllowRemote -Members (Get-ADGroup -Filter {Name -eq 'SalesAdmin'})
# Add-ADGroupMember -Identity AllAdmin -Members (Get-ADGroup -Filter * | Where-Object {$_.Name -in ('SalesAdmin','DevAdmin','MktgAdmin')})

# # Adding Admin users from each department to relevant Global groups
# Add-ADGroupMember -Identity SalesAdmin -Members (Get-ADUser -Filter * | Where-Object {$_.SamAccountname -in ('Maureen','Allan','Jessie')})
# Add-ADGroupMember -Identity MktgAdmin -Members (Get-ADUser -Filter * | Where-Object {$_.SamAccountname -in ('Ada','Ernie','Julian')})
# Add-ADGroupMember -Identity DevAdmin -Members (Get-ADUser -Filter * | Where-Object {$_.SamAccountname -in ('Jasper','Margret','Jodie')})


# Function to recursively retrieve nested group memberships


function Get-allmemberships {
  param (
    $SamAccountName = 'Jasper'
  )
  
  function Get-memberof {
    param (
      $ADObject
    )
    
    $Groups = Get-ADPrincipalGroupMembership -Identity $ADObject
    foreach ($Group in $Groups) {
      $Group | Select-Object -Property Name,GroupScope
      Get-memberof -ADObject $Group
    }
  }
  $Adaccount = Get-ADUser -Identity $SamAccountName
  Get-memberof -ADObject $Adaccount
}

Get-allmemberships