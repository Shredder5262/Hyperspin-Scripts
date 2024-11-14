#############################################################################
#Description: This script is designed to create a series of blank folders based
#on an xml list specified with the system name.
#Author: Andrew Sutcliffe
#Version: 0.00.1
#Date: 11/14/2024
###################################################################################
#Variables
# Read the XML file content
$Systemxmlname = "Atlus"

#Get xml list 
$xmlContent = Get-Content -Path "D:\HyperspinMasterbuild\Hyperspin\Databases\MAME\$Systemxmlname.xml"
$Newfolderdestination = "H:\RocketLauncher\Media\Bezels\Taito Classics\Folderlist\"
###################################################################################
#Read the XML
# Cast the content as an XML object
$xml = [xml]$xmlContent

# Access elements and attributes
$xmlgamelist = $xml.menu.game 

$mamename = $xmlgamelist.name

###################################################################################
#Create Blank Folder list
foreach ($nameentry in $mamename) {
    
   New-Item -Path "$Newfolderdestination\$nameentry" -ItemType Directory
}


