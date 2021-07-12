#Generally you want to use Powershell ISE,

#import az powershell module
Import-Module -name Az

#connect to az account
Connect-AzAccount

#Define AZ variables for VM
$vmName = "WingtiptoysVM"
$resourceGroup = "WingtiptoysRG"

#Create az credentials
$adminCredential = Get-Credential -Message "Enter a username and pw for VM admin."

#Create VM in azure:
New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS

#in cloudshell:

param([string]$resourceGroup)

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."

For ($i = 1; $i -le 3; $i++) 
{
$vmName = "ConferenceDemo" + $i
Write-Host "Creating VM: " $vmName
New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS
}

#this script will automate the creation of 3 VMs
#as always, make sure it worked...

Get-AzResource -ResourceType Microsoft.Compute/virtualMachines

#remove when done: 
Remove-AzResourceGroup -Name MyResourceGroupName