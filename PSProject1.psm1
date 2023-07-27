function Get-NewHires{
    Param(
        $CsvFilePath = "e:\NewHires.CSV",
        $BaseOU = "DC=Adatum,dc=com"
    )  

    $NewHires = Import-Csv -Path $CsvFilePath

    foreach ($NewHire in $NewHires){
        $FirstName = $NewHire.firstname
        $LastName = $NewHire.$LastName
        $Name = $FirstName +" "+ $LastName
        $SamAccountName = $FirstName[0] + $LastName
        $Password = (ConvertTo-SecureString -AsPlainText $NewHire.password -Force)
        $department = $NewHire.Department
        $SecurityGroup = $NewHire.
        $OuPath = "OU=$Department,$BaseOU"

        if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $department})) {
        New-ADOrganizationalUnit -Name $department -Path $baseOU -Description "Department: $department"
        Write-Host "OU '$department' created."
        }

        if (-not (Get-ADGroup -Filter {Name -eq $department})) {
            New-ADGroup -Name $SecurityGroup -GroupScope Global
            Write-Host "ScurityGroup '$SecurityGroup' created."
        }

        New-ADUser -Name $Name -Path $OuPath
        Add-member -Identity $SecurityGroup -Members $name






    }

}