
# MasterMind Game
Clear-Host
# Choose 4 random numbers from 1 through 6
$HiddenNumbers = 1..6 | Get-Random -Count 4
$Turns = 0
[System.Collections.ArrayList]$Tries = @()
do {
  $WrongPos = 0
  $RightPos = 0
  # Make sure the player types 4 unique numbers ranging from 1 to 6
  do {
    [int[]]$Guess = (Read-Host -Prompt 'Enter 4 numbers 1-6 with commas to separate').split(',')
    $Guess = $Guess | Select-Object -Unique
    $HighestNumber = ($Guess | Sort-Object -Descending)[0] 
  } until ($Guess.count -eq 4 -and $HighestNumber -le 6 )
  # Test for write and wrong positions
  foreach ($Index in 0..3) {
    if ($Guess[$Index] -eq $HiddenNumbers[$Index]) {$RightPos++}
    elseif ($Guess[$Index] -in $HiddenNumbers) {$WrongPos++}
  }
  $Hash = @{
    GuessArray = $Guess
    Right      = $RightPos
    Wrong      = $WrongPos
  }
  $Tries.Add($Hash)
  # Display all of the tries so far
  Clear-Host 
  foreach ($Try in $Tries) {
    Write-Host -ForegroundColor Yellow "$($Try.GuessArray) " -NoNewline 
    Write-Host -ForegroundColor Cyan "- RP $($Try.Right)  WP $($Try.Wrong) " 
  }
  $Turns++
} until ($RightPos -eq 4 -or $Turns -eq 12)
Write-Host 
# Determine if player wins or not
if ($Turns -eq 12 -and $RightPos -ne 4) {"Player loses"}
else {"Player wins"}