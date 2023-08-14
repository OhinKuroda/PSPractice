# Prompt for the number of VMs to create
$vmCount = Read-Host "Enter the number of VMs to create"

# Create an array to store the VM names
$vmNames = @()

# Loop through the specified number of VMs
for ($i = 1; $i -le $vmCount; $i++) {
    # Prompt for the name of each VM
    $vmName = Read-Host "Enter the name for VM$i"

    # Add the VM name to the array
    $vmNames += $vmName
}

# Loop through the VM names array and create the VMs
foreach ($name in $vmNames) {
    # Create the VM using the provided name
    New-VM -Name $name -MemoryStartupBytes 4GB -NewVHDPath "C:\VMs\$name.vhdx" -NewVHDSizeBytes 50GB
    # You can customize the New-VM command with additional parameters as per your requirements.
    
    Write-Host "VM '$name' created successfully!"
}

#command that installs remoteaccess on OS of Vm and routing setup
Install-WindowsFeature RemoteAccess -IncludeManagementTools
Install-WindowsFeature -Name Routing -IncludeManagementTools -IncludeAllSubFeature
Install-WindowsFeature -Name "RSAT-RemoteAccess-Powershell"
Install-RemoteAccess -VpnType RoutingOnly
Get-NetAdapter | Set-NetIPInterface -Forwarding Enabled