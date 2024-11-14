#############################################################################
#Description: This script has multiple functions that it does from getting a game name
#list from XML...
#
#Author: Andrew Sutcliffe
#Version: 0.00.1
#Date: 11/14/2024

#############################################################################

# Read the XML file content
$Systemxmlname = "Atlus"
$systemname = "Atlus"
###################################################################################
#Get xml list 
$xmlContent = Get-Content -Path "path to xml file\$Systemxmlname.xml"
###################################################################################
#Rlauncher Bezels
$MAMEBezelSourcePath = "path to mame folder\artwork\MAME"
$rlauncherBezelDestinationPath = "path to rlauncher bezels folder\$systemname"
###################################################################################
#Wheels
$WheelSourcePath = "path to hyperspin folder\Media\MAME\Images\Wheel"
$WheelDestinationPath = "path to hyperspin media folder\$systemname\Images\Wheel"
###################################################################################
#Themes
$ThemeSourcePath = "path to hyperspin folder\Media\MAME\Themes"
$ThemeDestinationPath = "path to hyperspin folder\Media\$systemname\Themes"
###################################################################################
#Video
$VideoSourcePath = "path to mame videos folder\MAME"
$VideoDestinationPath = "path to video destination path\$systemname"
###################################################################################
#Mame Bezels
$MAMEBezelSourcePath = "path to mame folder\artwork\MAME"
$MAMEBezelDestinationPath = "path to mame folder\artwork\$systemname"
###################################################################################
#Mame ini's 
$MAMEiniSourcePath = "path to mame folder\ini\MAME"
$MAMEiniDestinationPath = "path to mame folder\ini\$systemname"

###################################################################################
#Read the XML
# Cast the content as an XML object
$xml = [xml]$xmlContent

# Access elements and attributes
$xmlgamelist = $xml.menu.game 

$mamename = $xmlgamelist.name

###################################################################################
#Split Bezel images from MAME Main list in MAME folder
New-Item -Path $MAMEBezelDestinationPath -ItemType "directory"
foreach ($name in $mamename) {
    Copy-Item -Path "$MAMEBezelSourcePath\$name.zip" -Destination $MAMEBezelDestinationPath -ErrorAction SilentlyContinue
}
###################################################################################
#Split wheel images from MAME Main list
foreach ($name in $mamename) {
    Copy-Item -Path "$WheelSourcePath\$name.png" -Destination $WheelDestinationPath  -ErrorAction SilentlyContinue
}
###################################################################################
#Split Themes from MAME main list
foreach ($name in $mamename) {
    Copy-Item -Path "$ThemeSourcePath\$name.zip" -Destination $ThemeDestinationPath -ErrorAction SilentlyContinue
}
###################################################################################
#Split Videos from MAME main list
New-Item -Path $VideoDestinationPath -ItemType "directory"
foreach ($name in $mamename) {
    Copy-Item -Path "$VideoSourcePath\$name.mp4" -Destination $VideoDestinationPath -ErrorAction SilentlyContinue
}
###################################################################################
#Rlauncher Split Bezel images from MAME Main list in MAME folder to 
New-Item -Path $rlauncherBezelDestinationPath -ItemType "directory"
foreach ($name in $mamename) {
    Copy-Item -Path "$MAMEBezelSourcePath\$name.zip" -Destination $rlauncherBezelDestinationPath -ErrorAction SilentlyContinue
}
###################################################################################
#Split ini files from MAME Main list in MAME folder
New-Item -Path $MAMEiniDestinationPath -ItemType "directory"
foreach ($name in $mamename) {
    Copy-Item -Path "$MAMEiniSourcePath\$name.ini" -Destination $MAMEiniDestinationPath -ErrorAction SilentlyContinue
}

