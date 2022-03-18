################# XinLog 1.2 #################################################
# What's New? 
# Added Open-Log function to intialize the folder where to store the log
# It is optional, you can keep log as before leveraging on the current directory
# ....
# Use this library to log easely on file and screen
#---------------------------------------------------------
# Open-Log: initialize the Log in case a specific location to log is needed
#   In Parameter OPTIONAL
#   - $StoragePath [STRING] full path where to store the logs
#   - $Level [STRING] define the minimal level of the log among the "Info", "Warning", "Critical" 
#   The default path is the same directory of the caller
# Write-Log: write text to file and screen
#   In Parameters MANDATORY
#   - $LogString [STRING] Message to log
#   In Parameters OPTIONAL
#   - $Level [STRING] define the level of the log among the "Info", "Warning", "Critical"   
#   The log on file will create file in the the directory specified in the
#   Open-Log call or in the same directory of the caller
##############################################################################

$_ScriptName = "XinLog 1.2"
# Get the current Directory
$global:_StoragePath = Split-Path -Parent $MyInvocation.MyCommand.Path
#Set the file log name
$global:_Logfile = "$global:_StoragePath\XinLog_$($env:computername)_$((Get-Date).toString("yyyyMMdd_HHmmss")).log"
#Set the default minum log level
$global:_Level = "Info"

#begin FUNCTIONS

function Open-Log{
    Param (   
        [string]$StoragePath,
        [ValidateSet("Info", "Warning", "Critical")]
        [string]$Level="Info"
    )
    try{
        $global:_Level = $Level
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
        Write-Log "*************** $($_ScriptName) Initialized ******************" -Level "Critical"
        Write-Log "* Log stored here: $($global:_StoragePath)" -Level "Critical"
        Write-Log "* Log file name  : $($global:_Logfile)" -Level "Critical"
        Write-Log "* Log level      : $($global:_Level)" -Level "Critical"
        Write-Log "***************************************************************" -Level "Critical"        
    }

}

function Write-Log
{
    Param (
        [Parameter(Mandatory)]    
        [string]$LogString,
        [ValidateSet("Info", "Warning", "Critical")]
        [string]$Level="Info"
    )
    try{
        $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
        $LogMessage = "$Stamp - $Level - $LogString"
        if(($Level -eq "Info") -and ($global:_Level -eq "Info")){
            Add-content $global:_Logfile -value $LogMessage
            Write-Host $LogString -ForegroundColor White
        }
        elseif(($Level -eq "Warning") -and (($global:_Level -eq "Warning") -or ($global:_Level -eq "Info"))){
            Add-content $global:_Logfile -value $LogMessage
            Write-Host $LogString -ForegroundColor Yellow
        }
        elseif($Level -eq "Critical"){
            Add-content $global:_Logfile -value $LogMessage
            Write-Host $LogString -ForegroundColor Red
        }
    }
    Catch{
        Write-Host "$_ScriptName - (Write-Log) An error occurred:" -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor DarkYellow
        Write-Host "Logging may be affected and may not work properly" -ForegroundColor Red
    }
}

#end FUNCTIONS