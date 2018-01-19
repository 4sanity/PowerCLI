Add-PSSnapin VMware.VimAutomation.Core
. 'C:/Program Files (x86)/VMware/Infrastructure/vSphere PowerCLI/Scripts/Initialize-PowerCLIEnvironment.ps1'

###### Initilization done ######

# ENTER vCenter IP address or FQDN:
$vCenterAddress = "x.x.x.x"

# ENTER vCenter Username:
$vCenterUser = "example_username"

# ENTER vCenter Password:
$vPassword = "example_password"

# ENTER number of VMs to run invoke on:
$VMquantity = 1

# ENTER VM prefix name:
$VMprefix = "example_prefix"

# MODIFY this value to invoke the command to VMs starting with this postfix:
$index = 0

# ENTER the path for the script to invoke on selected VMs:
$invoke = "/script_file_location &"

# ENTER the guest operating system username for all of the selected VMs:
$gUsername = "example_guestOS_username"

# ENTER the guest operating system password for all of the selected VMs, given username:
$gPassword = "example_guestOS_password"

# ENTER script type (Bat, Powershell, or Bash):
$scriptType = "Bash"


###### Done with user modifications ######

#Connecting to vCenter...
Connect-VIServer $vCenterAddress -User $vCenterUser -Password $vPassword -WarningAction SilentlyContinue

#Loop through selected VMs...
1..$VMquantity | foreach {
    $VMname = $VMprefix + $index
    $vm = Get-VM $VMname

    Invoke-VMScript -VM $vm -ScriptText $invoke -GuestUser $gUsername -GuestPassword $gPassword -ScriptType $scriptType
    
    $index = $index + 1
}
