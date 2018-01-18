# PowerCLI
PowerCLI Scripts

Created for specialized VM deployment using PowerCLI in a VMware vSphere enviornment. These are specific to my project.

Requirement: PowerCLI must be installed on Windows.
Requirement: PowerCLI initilzation file in this location:
C:/Program Files (x86)/VMware/Infrastructure/vSphere PowerCLI/Scripts/Initialize-PowerCLIEnvironment.ps1


Files:
AddDatastores - Add datastores to a ESX host from 3PAR LUNs already exported to the host.
DeployVMs - Deploy VMs, with no OS customization, in a loop, on precreated datastores, 3 different methods available.
InvokeCommand - Invoke a command/script on a certain number of VMs in a loop.
