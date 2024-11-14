#############################################################################
#Description: This script is designed target a file path and remove all directories
#that do not contain any files. 
#Author: Andrew Sutcliffe
#Version: 0.00.1
#Date: 11/14/2024
#############################################################################

# Specify the target directory
$targetDirectory = "Target folder list"
#############################################################################

# Function to delete empty folders recursively
function Remove-EmptyFolders {
    param (
        [string]$FolderPath
    )

    # Get all subdirectories
    $subdirectories = Get-ChildItem -Path $FolderPath -Directory

    # Process each subdirectory recursively
    foreach ($subdirectory in $subdirectories) {
        # Call the function on each subdirectory
        Remove-EmptyFolders -FolderPath $subdirectory.FullName
    }

    # Check if the current folder is empty after processing subdirectories
    if ((Get-ChildItem -Path $FolderPath -File -Recurse).Count -eq 0) {
        Remove-Item -Path $FolderPath -Recurse
        Write-Output "Deleted empty folder: $FolderPath"
    }
}

# Call the function on the target directory
Remove-EmptyFolders -FolderPath $targetDirectory