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
