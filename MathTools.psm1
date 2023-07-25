#psm1 means that its maid to be a module
#must never call function in a module
#one funtion for adding and one for multiplying

function Get-Addition {
    param (
        $Num1,
        $Num2     
    )
    return $Num1 + $Num2
}

function Get-Multiplication {
    param (
        $Num1,
        $Num2
    )
    return $num1 * $num2
}