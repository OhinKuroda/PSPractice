$h1 = @{
    Doors = 4
    Wheels = 4
    EngineType = 'Gas'
}

$h2 = @{
    Doors = 4
    Wheels = 4
    EngineType = 'Electric'
}

[System.Collections.ArrayList]$Cars = @()

$Cars.add($h1)

$Cars