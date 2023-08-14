#using a json file downloaded from github

$location = 'eastus'
$rgName = 'az104-06-rg1'

New-AzResourceGroupDeployment `
  -ResourceGroupName $rgName `
  -TemplateFile $HOME/az104-06-vms-loop-template.json `
  -TemplateParameterFile $HOME/az104-06-vms-loop-parameters.json


  $rgName = 'az104-06-rg1'
  $location = (Get-AzResourceGroup -ResourceGroupName $rgName).location
  $vmNames = (Get-AzVM -ResourceGroupName $rgName).Name
  
  foreach ($vmName in $vmNames) {
   Set-AzVMExtension `
   -ResourceGroupName $rgName `
   -Location $location `
   -VMName $vmName `
   -Name 'networkWatcherAgent' `
   -Publisher 'Microsoft.Azure.NetworkWatcher' `
   -Type 'NetworkWatcherAgentWindows' `
   -TypeHandlerVersion '1.4'
  }