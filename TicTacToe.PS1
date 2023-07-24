#Interactive game
#   1 | 2 | 3
#   --+---+---
#   4 | 5 | 6
#   --+---+---
#   7 | 8 | 9



function DisplayBoard {
param($Board)
Write-Host " $($Board[0]) | $($Board[1]) | $($Board[2])"
Write-Host "---+---+---"
Write-Host " $($Board[3]) | $($Board[4]) | $($Board[5])"
Write-Host "---+---+---"
Write-Host " $($Board[6]) | $($Board[7]) | $($Board[8])"
Write-Host
}


do {

    $CurrentPlayer = 'X', 'O' | Get-Random
    [System.Collections.ArrayList]$TicTacToeBoard = @(1,2,3,4,5,6,7,8,9)
    $Gameover = $False
    $Draw = $False
    $KeepPlaying = $False
    do {

        #print the board
        DisplayBoard -Board $TicTacToeBoard
        # Ask for input, declare whos turn it is X or O
        do{
                
                $Choice = Read-Host -Prompt "Player $CurrentPlayer, please choice your spot"
              # Check for wrong responses: Not 1-9, or already chosen
              # if wrong, ask again
                $GoodSpots = @(1,2,3,4,5,6,7,8,9)
                if ($TicTacToeBoard -and $GoodSpots -contains  $Choice) {$TryAgain = $False}
                else {$TryAgain = $True }
           } while($TryAgain -eq $True)

         #populate board to reflect choice
        $TicTacToeBoard[$Choice - 1] = $CurrentPlayer
        #check game state (win,lose,draw)

        $WinningLines = @(
            @(0,1,2),
            @(3,4,5),
            @(6,7,8),
            @(0,3,6),
            @(1,4,7),
            @(2,5,8),
            @(0,4,8),
            @(2,4,6)
        )
        foreach ($WinningLine in $WinningLines) {
            $PositionValues = ($TicTacToeBoard[$WinningLine] | Select-Object -Unique)
            if ($PositionValues.count -eq 1) {
                $GameOver = $True
                break
            }
        } 
        if($Gameover -eq $False -and ($TicTacToeBoard | Select-Object -Unique).count -eq 2) {
            $Draw = $True
            $Gameover = $True
            DisplayBoard -Board $TicTacToeBoard
            Write-Host "      It's a DRAW!!!!"
            
        }      
        #Win = 3 in a row, col, diag 8
        if ($Gameover -eq $False) {
            if ($CurrentPlayer -eq 'X') {$CurrentPlayer = 'O'}
            else {$CurrentPlayer = 'X'}
           
        }
    } until($GameOver -eq $True)
    
    if($Gameover -eq $true -and $Draw -eq $False){
        DisplayBoard -Board $TicTacToeBoard
        Write-Host "      $CurrentPlayer WINS!!!"
    }
#check for play again and then reset board
    $PlayAgain = Read-Host -Prompt "Do you want to play again [y] [n]"
    if ($PlayAgain -like 'y*') {$KeepPlaying = $True}
    else{$KeepPlaying = $False}
    

} while ($KeepPlaying -eq $True)