#Here we go and some new changes

Write-Host 'Hello World'

start-vm -name 'Test Lab'
Stop-VM 'test lab'

get-vm | Set-VMBios -EnableNumLock
