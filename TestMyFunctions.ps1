function AreaOfRectangle {
    param (
        $length,
        $Width

    )
    
    $Area = $Length * $Width
    return $Area
    
}

$AreaOfObject = AreaOfRectangle -length 5 -Width 10
$AreaOfObject

#Importing the module I made
Import-Module C:\PSPractice\MathTools.psm1
Get-Addition -Num1 10 -Num2 20
Get-Multiplication -Num1 10 -Num2 20

#Find preloaded module path
$env:PSModulePath -split ';'
#To make a module pre-Loaded:
#make a directory in C:\Program Files\WindowsPowerShell\Modules
#and create and name a folder with the same name as the module (ex. for Module MathTools.psm1 -> folder = MathTools)
#Get-Module wont show the module until you use it
#If you make changes to  a module ou need to uninstall the module then reimport the module again to get the new one
# also check the local function drive if youre using the same shell (Get-ChildItem function:) (RemoveItem -path Function:\Get-Addition)