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

#to make different versions go to the module folder and create a folder and name it the version Number (1.0.0) and place your module inside
#PS C:\PSPractice> cd 'C:\Program Files\WindowsPowerShell\Modules\MathTools\1.0.0\'        
#New-ModuleManifest -path .\MathTools.psd1-RootModule .\MathTools.psm1 -Author 'Ohin C' -Description 'Give some math tools' -FunctionsToExport Get-Addition, Get-Multiplication -ModuleVersion '1.0.0'
