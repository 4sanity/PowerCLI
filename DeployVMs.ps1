Add-PSSnapin VMware.VimAutomation.Core
. 'C:/Program Files (x86)/VMware/Infrastructure/vSphere PowerCLI/Scripts/Initialize-PowerCLIEnvironment.ps1'

###### Initilization done ######

# ENTER vCenter IP address or FQDN:
$vCenterAddress = "x.x.x.x"

# ENTER vCenter Username:
$vCenterUser = "example_username"

# ENTER vCenter Password:
$vPassword = "example_password"

# ENTER the number of VMs to be deployed:
$VMquantity = 1

# ENTER the name of the host to deploy the VMs to:
$hostName = "x.x.x.x"

# ENTER VM prefix:
$VMprefix = "example_vm_prefix_name"

# ENTER the template or vm name that will be cloned, or skip this step if using OVF deployment method:
$template = "example_template_name"
$clone = Get-VM example_vm_name

# ENTER datastore prefix:
$datastorePrefix = "example_datastore_prefix_name"

# ENTER name of the cluster to deploy VMs to (when using a cluster and only if datastores can be accessed from all hosts):
#$clusterName = "example_cluster_name"

# MODIFY this value if you would like to offset the VM name and datastore deployment:
$index = 0

# ENTER file path to the OVF, or skip this step if not using the OVF deployment method:
$sourcePath = "C:\ExampleFilePath"

# Connecting to vCenter...
Connect-VIServer $vCenterAddress -User $vCenterUser -Password $vPassword -WarningAction SilentlyContinue

# Deploys in a loop, additional VM cloning starts everytime one finishes...
# UNCOMMENT the method intended for VM deployment:
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
    #$DeployVM = New-VM -Name $VMname -VM $clone -Datastore $datastoreName -DiskStorageFormat Thin -VMHost $hostName -ErrorAction stop
    
    $index = $index + 1
    Start-VM $VMname -Confirm:$false
}
