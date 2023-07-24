#Interactive game
#   1 | 2 | 3
#   --+---+---
#   4 | 5 | 6
#   --+---+---
#   7 | 8 | 9

$CurrentPlayer = 'X'. 'O' | Get-Random
[System.Collections.ArrayList]$TicTacToeBoard = @(1,2,3,4,5,6,7,8,9)

do {
    do {

        #print the board
        Write-Host " $($TicTacToeBoard[0]) | $($TicTacToeBoard[1]) | $($TicTacToeBoard[2])"
        Write-Host "---+---+---"
        Write-Host " $($TicTacToeBoard[3]) | $($TicTacToeBoard[4]) | $($TicTacToeBoard[5])"
        Write-Host "---+---+---"
        Write-Host " $($TicTacToeBoard[6]) | $($TicTacToeBoard[7]) | $($TicTacToeBoard[8])"

        # Ask for input, declare whos turn it is X or O
        # Check for wrong responses: Not 1-9, or already chosen
        # if wrong, ask again

        #populate board to reflect choice

        #check game state (win,lose,draw)
        #Win = 3 in a row, col, diag 8
    } until($GameOver)
#check for play again and then reset board
} while ($KeepPlaying)