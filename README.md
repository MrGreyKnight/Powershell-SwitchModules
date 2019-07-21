# Powershell-SwitchModules (Windows only powershell 5)
This is a general repository for powershell scripts I create for use in switch content

## How to use | Global Import Coming soon

Open windows powershell.exe (right click on the windows button on the taskbar)

```PowerShell
##Sets the excution policy to allow you to run the scripts for this session (required everytime)
Set-ExecutionPolicy - Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

##Import the modules
##Change file location to where you have the files saved (required everytime)
Import-Module 'C:\Users\GN000001\Downloads\Git\Powershell-Switch-Modules\'
```

This will import the modules and make them available for use during the powershell window is open.


## Expand-SwitchPhotoLibrary
Sorts the screenshots from the switch into a more usable folder structure.


```PowerShell
##Sets the excution policy to allow you to run the scripts for this session (required everytime)
Set-ExecutionPolicy - Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

##Import the modules
##Change file location to where you have the files saved (required everytime)
Import-Module 'C:\Users\GN000001\Downloads\Git\Powershell-Switch-Modules\Expand-SwitchPhotoLibrary\Expand-SwitchPhotoLibrary.ps1'
```

```PowerShell

Expand-SwitchPhotoLibrary -source 'Directory screenshots are saved' -destination 'Directory you want them moved to when they are sorted' -gameListFile 'Directory game_ids.json is saved'
```
This will go through and sort your screenshots or videos

```
Folder Structure

--Destination Folder
----Game
------FileType
--------Year
----------Month
------------Day
--------------Saved File

```
