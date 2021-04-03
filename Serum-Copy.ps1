param (
        [Parameter(Mandatory = $true, ValueFromPipeline, Position = 0)]
        [string]$PacksFolder, # F:\Downloads\Completed\Presets\Serum

        [Parameter(Mandatory = $false, ValueFromPipeline, Position = 1)]
        [string]$SerumFolder = (Join-Path $env:USERPROFILE "Documents\Xfer\Serum Presets")
)

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;

# Global Configuration
$MaxDirectoryDepthSearch = 5

$noisesDirectoryMatchFilter = @('Serum Noises','Noises','noise')
$lfoDirectoryMatchFilter = @('LFO','','')
$presetsDirectoryMatchFilter = @('Serum Presets','Presets','preset')
$tablesDirectoryMatchFilter = @('Serum Tables','Tables','table')




function Copy-Packs
{
    param (
        [string]$PacksFolder,
        [string[]]$Filters
    )

        # get all folders for the serum packs
        $packs = Get-PackNames -PacksFolder $PacksFolder -Filter $filter
        foreach ($pack in $packs) 
        {
            # path of a single pack
            $packPath = (Join-Path $SerumFolder $pack)
            foreach ($filter in $Filters) 
            {
                
            }
        }
}

function Get-PackNames
{
    param (
        [string]$PacksFolder,
        [string]$Filter
    )

    return Get-ChildItem -Path $PacksFolder -Filter $Filter -Recurse -Directory -Depth 0 | Select-Object -Property Name
}

function Get-PresetsFolder
{
    param (
        [string]$PacksFolder,
        [string]$Filter
    )


    return Get-ChildItem -Path $PacksFolder -Filter $Filter -Recurse -Directory
}

function Get-NoisesFolder
{
    param (
        [string]$PackFolder,
        [string]$Filter
    )

    $noiseFolderFoundFlag = $false
    $directoryDepth = 0
    while ($noiseFolderFoundFlag -eq $false -and $directoryDepth -le $MaxDirectoryDepthSearch) {
        try {
            Get-ChildItem -Path $PackFolder -Filter $Filter -Recurse -Directory -Depth $directoryDepth
        } 
        finally {
            ++$directoryDepth
        }
    }

    return Get-ChildItem -Path $PacksFolder -Filter $Filter -Recurse -Directory -Depth 0
}


Traverse -Depth 0 -> 5





# LFO Shapes - Create Single Level Folder for Reach Pack
#.shp

# Noises
#.wav .aif

# Presets
#.fxp

# Skins

# System

# Tables
#.wav

# Copy-Packs -PacksFolder $PacksFolder