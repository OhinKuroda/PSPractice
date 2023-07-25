#psm1 means that its maid to be a module
#must never call function in a module
#one funtion for adding and one for multiplying

#psm1 means that its maid to be a module
#must never call function in a module
#one funtion for adding and one for multiplying

function Get-Addition {
    <#
    .SYNOPSIS
        This command adds two numbers together'
    .DESCRIPTION
        This command takes two inputs as parameters and then adds them together. 
        It produces a PS object showing the two numbers and the result
    .NOTES
        Created by Ohin Carter
        ChangeLog:
        Date                   Version              What was changed
        ----                   --------             ----------------
        24/Jul/2023             1.0.0               Script was created
        24/Jul/2023             1.0.5               added division
        24/Jul/2023             1.1.0               added help info and cmdletbinding
    
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
       Get-addition -num1 10 -num2 20

    .PARAMETER Num1
        This is the first number

    .PARAMETER Num2
        This is the second
    #>
    [CmdletBinding()]
    param (
        $Num1,
        $Num2     
    )
    $AddHash = [ordered]@{
        Num1 = $Num1
        Num2 = $Num2
        Result = $Num1 + $Num2

    }
    $ResultObj = New-Object -TypeName psobject -Property $AddHash
    return $ResultObj
}

function Get-Multiplication {
    <#
   .SYNOPSIS
        This command multiplies two numbers together'
    .DESCRIPTION
        This command takes two inputs as parameters and then multiplies them together. 
        It produces a PS object showing the two numbers and the result
    .NOTES
        Created by Ohin Carter
        ChangeLog:
        Date                   Version              What was changed
        ----                   --------             ----------------
        24/Jul/2023             1.0.0               Script was created
        24/Jul/2023             1.0.5               added division
        24/Jul/2023             1.1.0               added help info and cmdletbinding
    
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
       Get-multiplication -num1 10 -num2 20

    .PARAMETER Num1
        This is the first number

    .PARAMETER Num2
        This is the second number
    #>
    
    
    [CmdletBinding()]
    param (
        $Num1,
        $Num2
    )
    
    $MultHash = [Ordered]@{
        Num1 = $Num1
        Num2 = $Num2
        Result = $Num1 * $Num2

    }
    $ResultObj = New-Object -TypeName psobject -Property $MultHash
    return $ResultObj
    
}


function Get-Division {
    <#
.SYNOPSIS
        This command divides two numbers against eachother'
    .DESCRIPTION
        This command takes two inputs as parameters and then divides them. 
        It produces a PS object showing the two numbers and the result
    .NOTES
        Created by Ohin Carter
        ChangeLog:
        Date                   Version              What was changed
        ----                   --------             ----------------
        24/Jul/2023             1.0.0               Script was created
        24/Jul/2023             1.0.5               added division
        24/Jul/2023             1.1.0               added help info and cmdletbinding
    
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
       Get-division -num1 10 -num2 20

    .PARAMETER Num1
        This is the first number

    .PARAMETER Num2
        This is the second number
    #>
    
    
    [CmdletBinding()]
    param (
        $Num1,
        $Num2
    )
    
    $DivHash = [Ordered]@{
        Num1 = $Num1
        Num2 = $Num2
        Result = $Num1 / $Num2

    }
    $ResultObj = New-Object -TypeName psobject -Property $DivHash
    return $ResultObj
    
}

#to make different versions go to the module folder and create a folder and name it the version Number (1.0.0) and place your module inside
#PS C:\PSPractice> cd 'C:\Program Files\WindowsPowerShell\Modules\MathTools\1.0.0\'        
#New-ModuleManifest -path .\MathTools.psd1 -RootModule .\MathTools.psm1 -Author 'Ohin C' -Description 'Give some math tools' -FunctionsToExport Get-Addition, Get-Multiplication -ModuleVersion '1.0.0'
#for a new version increase -moduleversion to desired number and add the necessary funtions to -functiontoexport