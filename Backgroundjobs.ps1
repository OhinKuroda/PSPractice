Get-command -ParameterName asjob

Invoke-Command -AsJob -JobName

Start-job -ScriptBlock {Get-Service} -Name Ohinsservices
Recieve-job -Id1 -Keep
Get-Job -IncludeChildJob
Invoke-command -ComputerName lon-dc1,lon-svr1 -ScriptBlock {Get-Process -Name csrss} -AsJob

Get-Command -Noun Job


#scheduled tasks and scheduled jobs are different
#Scheduled task can't capture and manipulate task output
#
#Job Options
#$opt = New-ScheduledJobOption –RequireNetwork –RunElevated -WakeToRun
#
#Job Triggers
#$trigger = New-JobTrigger -Weekly -DaysOfWeek Monday,Thursday -At '3:00PM'
#
#RegisterJobs
#Register-ScheduledJob -Trigger $trigger -ScheduledJobOption $opt -ScriptBlock { Dir C:\ } -MaxResultCount 5 -Name "LocalDir"
#