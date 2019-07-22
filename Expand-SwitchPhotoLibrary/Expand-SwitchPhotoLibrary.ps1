<#
    .NOTES
    ==================================================================================
    Created on: 21/07/2019
    Created By: MrGreyKnight
    Filename: Expand-SwitchPhotoLibrary.ps1
    
    .DESCRIPTION
    Allows the user to sort their switch screenshot library in a more human usable folder structure.

    .PARAMETER sourceLocation
    The source of the screenshots.

    .PARAMETER expandLocation
    The destination for the sorted folders and files

    .PARAMETER jsonIdLocation
    Json file location containing all the game name file related to their ids
#>
function Expand-SwitchPhotoLibrary
{
    param
    (
        [string]$source,
        [string]$destination,
        [string]$gameListfile,
        [switch]$datefolder
    )

    if(!(Test-Path $gameListfile)) 
    {
        Write-Error -Message 'Failed to find game_id file.'
        Write-Error -Message 'Not found at stated location : ' + $gameListfile;
    } else 
    {
        
        $jsonGameId = (Get-Content $gameListfile -Raw) | ConvertFrom-Json

        $screenshots = get-childitem -Path $source -File -recurse

        foreach ($file in $screenshots)
        {
            $gameId = [regex]::matches($file.name,"\-(.*?)\.").Groups[1].Value

            $gameName = $jsonGameId.psobject.properties | Where-Object { $_.Name -eq $gameId }

            if($null -eq $gameName.value) 
            {
                $gameFolder = "Unknown_game"
                Write-OutPut "Unknown Game Found, Please if know update the git repo so this doesnt happen for other users. $($file.name)"
            } else 
            {
                $gameFolder = $gameName.value
            }

            $year  = $file.name.substring(0, 4)
            $month = $file.name.substring(4, 2)
            $day   = $file.name.substring(6, 2)

            $extension = $file.Extension.substring(1)

            if ($destination -notmatch '.+?\\$')
            {
                $destination += '\'
            }
            if($datefolder) 
            {
                $expandfinal = $destination + [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($gameFolder)) + '\' + $extension + '\' + $year + '\' + $Month + '\' + $day
            } else 
            {
                $expandfinal = $destination + [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($gameFolder)) + '\' + $extension + '\' + $year + '-' + $Month + '-' + $day
            }
            If(!(Test-Path $expandfinal))
            {
                New-Item -ItemType Directory -Force -Path $expandfinal | Out-Null
            }
            
            Copy-Item -Path $file.FullName -Destination $expandfinal -Recurse
        }
    }

}
