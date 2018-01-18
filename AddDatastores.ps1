Add-PSSnapin VMware.VimAutomation.Core
. 'C:/Program Files (x86)/VMware/Infrastructure/vSphere PowerCLI/Scripts/Initialize-PowerCLIEnvironment.ps1'

#######################################################################################################################
###### Initilization ends here, my script begins here ######
#######################################################################################################################

# Enter vCenter IP address here:
$vCenterAddress = "x.x.x.x"

# Enter vCenter Username here:
$vCenterUser = "example"

# Enter vCenter Password here:
$vPassword = "example"

#Connecting to vCenter...
Connect-VIServer $vCenterAddress -User $vCenterUser -Password $vPassword -WarningAction SilentlyContinue

# Datastore prefix name (0 based, modify the index if necessary):
$DSprefix = "scale_ds_300g."

# Name of the host that the LUNs are exported to:
$hostName = "x.x.x.x"

#Modify this value if you would like to offset the datastore path position and naming:
$index = 75

# At this point the LUNs should be manually exported from 3PAR and the host, rescanning HBAs now
Get-VMHostStorage -VMHost $hostName -RescanAllHba

# Add all of the LUNs that are exported from 3PAR to this host into a variable
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