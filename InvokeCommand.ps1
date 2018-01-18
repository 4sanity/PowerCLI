Add-PSSnapin VMware.VimAutomation.Core
. 'C:/Program Files (x86)/VMware/Infrastructure/vSphere PowerCLI/Scripts/Initialize-PowerCLIEnvironment.ps1'

###### Initilization done ######

# ENTER vCenter IP address or FQDN:
$vCenterAddress = "x.x.x.x"

# ENTER vCenter Username:
$vCenterUser = "example_username"

# ENTER vCenter Password:
$vPassword = "example_password"

# ENTER the name of the host that the LUNs are exported to:
$hostName = "x.x.x.x"

# ENTER the script/command to be invoked:
$

# MODIFY this value if you would like to offset the VMs this command will be run on:
$index = 0


###### Done with user modifications ######

#Connecting to vCenter...
Connect-VIServer $vCenterAddress -User $vCenterUser -Password $vPassword -WarningAction SilentlyContinue

#Loop through VMs
