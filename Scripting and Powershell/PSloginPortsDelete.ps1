Get-Help Get-ChildItem -detailed

Get-Module

Install-Module -Name Az -AllowClobber -SkipPublisherCheck
//gets Az package for powershell to be able to use.

Set-ExecutionPolicy RemoteSigned
// only if needed due to errors

Update-Module -Name Az
// update Az

Import-Module Az
// import to powershell and start using

Connect-AzAccount
// connect your az cloud AzAccount

Select-AzSubscription -SubscriptionId '<SubscriptionId>'
//selects the subscription you want

Get-AzResourceGroup  /*(OR)*/ Get-AzResourceGroup | Format-Table
//get resource groups

New-AzResourceGroup -Name <name> -Location <location>
//create new resource group

//Verify the resources:

Get-AzResource
//OR for format table;  Get-AzResource | ft

//or filter so its only resources associated with group
Get-AzResource -ResourceGroupName ExerciseResources

//Create azure VM

New-AzVm -ResourceGroupName <resource group name> -Name <machine name> -Credential <credentials object> -Location <location> -Image <image name>

// Can also be used with Get-Credential cmdlet to supply credential:
New-AzVM -Name MyVm -ResourceGroupName ExerciseResources -Credential (Get-Credential) -Location <location> -Image <image name>

//Extra commands for the AzVM:  Remove-AzVM, Start-AzVM, Stop-AzVM, Restart-AzVM, Update-AzVM

// define vm in a variable:
$vm = Get-AzVM  -Name MyVM -ResourceGroupName ExerciseResources

// Open a port for an existing vm 
$ az vm open-port -g MyResourceGroup -n MyVm --port 80

// save the vm to variable and query it:
$vm = (Get-AzVM -Name "<vmname>" -ResourceGroupName <rgname>)
$vm

//get details, specifically in this case, get the IP address of the VM. (use .)
$vm | Get-AzPublicIpAddress

//ssh in to the VM
ssh bob@205.22.16.5

// delete VM:
   // Stop
   Stop-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName
   // Remove
   Remove-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName

//Check resources in your Resource group
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | ft

// We still need to delete other resources:
//network interface
$vm | Remove-AzNetworkInterface –Force
//OS disks / storage Account
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
//Virtual network
Get-AzVirtualNetwork -ResourceGroup $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
//The Network Security Group NSG
Get-AzNetworkSecurityGroup -ResourceGroup $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
//Delete public IP address
Get-AzPublicIpAddress -ResourceGroup $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force
//check again:
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | ft

Good to go!