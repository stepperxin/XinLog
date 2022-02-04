################# XinLog 1.0 ######################
# Use this library to log easely on file and screen
# In Parameters MANDATORY
#   - $LogString [STRING] Message to log
# The log on file will create file a file in the same directory of the caller
###################################################

# Get the current Directory
$myDir = Split-Path -Parent $MyInvocation.MyCommand.Path
#Set the file log name
$Logfile = "$myDir\XinLog_$($env:computername)_$((Get-Date).toString("yyyyMMdd_HHmmss")).log"

#begin FUNCTIONS
function Write-Log
{
    Param (
        [Parameter(Mandatory)]    
        [string]$LogString
    )
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $LogMessage = "$Stamp - $LogString"
    Add-content $LogFile -value $LogMessage
    Write-Host $LogString -ForegroundColor White
}

#end FUNCTIONS