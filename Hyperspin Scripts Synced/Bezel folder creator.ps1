#############################################################################
#Description: This script is designed to Copy all bezel files from a source Folder
#to a destination folder and also copy a declared .ini file to each folder as many
#times as each bezel that exists in the subfolder.
#Example: pacman>file1.png file1.ini,file2.png file2.ini,file3.png file3.ini, etc...
#Author: Andrew Sutcliffe
#Version: 0.00.1
#Date: 11/14/2024

#############################################################################
#Variables
$Sourcefolder = 
$Blankfolder = 
$inifile = 

#############################################################################

#Make a unique list of folder names
$Filename = $(get-childitem -Path $Sourcefolder ).Name
$Folderlist = @()
foreach ($entry in $Filename) {
    $firstWord = ($entry -split ' ')[0]

    $Folderlist += $firstWord
}
$uniquefolderlist = $Folderlist | Get-Unique 
#############################################################################
#use folder list to create folder structure from source and copy each bezel to its corresponding folder
foreach ($item in $uniquefolderlist) {
    $Destinationfolder = New-Item -Path "$Blankfolder\$item" -ItemType Directory
    $originalfile = $(Get-ChildItem -Path $Sourcefolder  -Filter ($item + '*')).FullName
    Copy-Item -Path $originalfile -destination $Destinationfolder

}
#############################################################################
#Make a unique bezel path list and store it in a variable
$Bezelpathlist = $(Get-ChildItem -Path $Blankfolder -Recurse).Directory.fullname
$uniquebezelpath = $Bezelpathlist|Get-Unique
#############################################################################
#Copy the ini file to each folder for each .png file that exists.
foreach ($folderpath in $uniquebezelpath ) {
    # Get the number of files in the destination directory
    $fileCount = (Get-ChildItem -Path $folderpath| Measure-Object).Count

    # Copy the source file multiple times
    1..$fileCount | ForEach-Object {
        $newFileName = "Bezel $($_.ToString("000")).ini" 
        Copy-Item -Path $inifile -Destination "$folderpath\$newFileName"
    }
}
#############################################################################
Clear-Variable -Name Folderlist