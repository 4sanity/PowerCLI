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

# Change these variables based on the VMs you would like deploy:
# Number of VMs:
$VMquantity = 75

# Host to deploy the VMs to:
$hostName = "x.x.x.x"

# VM prefix name (0 based, modify the index if necessary):
$VMprefix = "scale"

# Name of the VM template / clone to use in the vCenter:
#$template = "rhel7-vd"
$clone = Get-VM rhel7-vd

# Datastore prefix name that the VM will deployed on (0 based, modify the index if necessary):
$datastorePrefix = "scale_ds_300g."

# Name of the cluster to deploy to (only if datastores can be accessed from all hosts):
#$clusterName = "Cluster1"

#Modify this value if you would like to offset the VM deployment:
$index = 75

#File path to the OVF if this is the deployment method:
#$sourcePath = "C:\Users\Administrator\Desktop\rhel7-vd.ovf"

# Deploys in a loop, additional VM cloning starts everytime one finishes
1..$VMquantity | foreach {
    $VMname = $VMprefix + $index
    $datastoreName = $datastorePrefix + $index
    
    # For OVF
    #Import-VApp -Source $sourcePath VMHost -$hostName -Name $VMname -Datastore $datastoreName -DiskStorageFormat Thin -ErrorAction stop
    
    # For templates
    #New-vm -Name $VMname -VMHost $hostName -Template $template -Datastore $datastoreName -DiskStorageFormat Thin -ErrorAction stop
    # by cluster instead of host:
    #New-vm -Name $VMname -ResourcePool $clusterName -Template $template -Datastore $datastoreName -DiskStorageFormat Thin -ErrorAction stop

    # For cloning
    $DeployVM = New-VM -Name $VMname -VM $clone -Datastore $datastoreName -DiskStorageFormat Thin -VMHost $hostName -ErrorAction stop
    
    $index = $index + 1
    Start-VM $VMname -Confirm:$false
}