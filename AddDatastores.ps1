Add-PSSnapin VMware.VimAutomation.Core
. 'C:/Program Files (x86)/VMware/Infrastructure/vSphere PowerCLI/Scripts/Initialize-PowerCLIEnvironment.ps1'

###### Initilization done ######

# ENTER vCenter IP address or FQDN:
$vCenterAddress = "x.x.x.x"

# ENTER vCenter Username:
$vCenterUser = "example_username"

# ENTER vCenter Password:
$vPassword = "example_password"

# ENTER datastore prefix:
$DSprefix = "example_datastore_prefix_name"

# ENTER the name of the host that the LUNs are exported to:
$hostName = "x.x.x.x"

# MODIFY this value if you would like to offset the datastore naming pattern:
$index = 0


###### Done with user modifications ######

#Connecting to vCenter...
Connect-VIServer $vCenterAddress -User $vCenterUser -Password $vPassword -WarningAction SilentlyContinue

# At this point the LUNs should be manually exported from 3PAR and the host, rescanning HBAs now
Get-VMHostStorage -VMHost $hostName -RescanAllHba

# Add all of the LUNs that are exported from 3PAR to this host into a variable, filtered for 3PAR LUNs, change if necessary
$LUNS = Get-SCSILun -VMHost $hostName -LunType disk -CanonicalName "naa.60002*"

# Loop through all of the LUNs and add them as datastores
foreach($LUN in $LUNS) {
    $DSname = $DSprefix + $index
    $DSpath = $LUN.CanonicalName
    New-Datastore -VMHost $hostName -Name $DSname -Path $DSpath -Vmfs
    $index = $index + 1
}

# Rescan datastores on host after finished
Get-VMHostStorage -VMHost $hostName -RescanAllHba
