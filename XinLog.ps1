################# XinLog 1.1 #################################################
# What's New? 
# Added Open-Log function to intialize the folder where to store the log
# It is optional, you can keep log as before leveraging on the current directory
# ....
# Use this library to log easely on file and screen
#---------------------------------------------------------
# Open-Log: initialize the Log in case a specific location to log is needed
#   In Parameter OPTIONAL
#   - $StoragePath [STRING] full path where to store the logs
#   The default path is the same directory of the caller
# Write-Log: write text to file and screen
#   In Parameters MANDATORY
#   - $LogString [STRING] Message to log
#   The log on file will create file in the the directory specified in the
#   Open-Log call or in the same directory of the caller
##############################################################################

$_ScriptName = "XinLog 1.0"
# Get the current Directory
$global:_StoragePath = Split-Path -Parent $MyInvocation.MyCommand.Path
#Set the file log name
$global:_Logfile = "$global:_StoragePath\XinLog_$($env:computername)_$((Get-Date).toString("yyyyMMdd_HHmmss")).log"

#begin FUNCTIONS

function Open-Log{
    Param (   
        [string]$StoragePath
    )
    try{
        if($StoragePath -ne $null){
            if (($StoragePath) -and (Test-Path -Path $StoragePath)){
                #set the folder name
                $global:_StoragePath = $StoragePath
                #Set the file log name
                $global:_Logfile = "$global:_StoragePath\XinLog_$($env:computername)_$((Get-Date).toString("yyyyMMdd_HHmmss")).log"
            }
            else{
                Write-Host "The specified directory $StoragePath is not present! XinLog will use the default one." -ForegroundColor DarkYellow
            }
        }
    }
    catch{
        Write-Host "$_ScriptName - (Open-Log) An error occurred:" -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor DarkYellow
        Write-Host "Logging may be affected and may not work properly" -ForegroundColor Red
    }
    finally{
        Write-Log "*************** $($_ScriptName) Initialized ******************"
        Write-Log "* Log stored here: $($global:_StoragePath)"
        Write-Log "* Log file name: $($global:_Logfile)"
        Write-Log "*************** ************************************************"        
    }



}

function Write-Log
{
    Param (
        [Parameter(Mandatory)]    
        [string]$LogString
    )
    try{
        $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
        $LogMessage = "$Stamp - $LogString"
        Add-content $global:_Logfile -value $LogMessage
        Write-Host $LogString -ForegroundColor White
    }
    Catch{
        Write-Host "$_ScriptName - (Write-Log) An error occurred:" -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor DarkYellow
        Write-Host "Logging may be affected and may not work properly" -ForegroundColor Red
    }
}

#end FUNCTIONS