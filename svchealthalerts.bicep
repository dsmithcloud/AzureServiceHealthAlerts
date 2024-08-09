// DISCLAIMER: This code is provided "as is" without warranty of any kind, 
// either express or implied, including but not limited to the implied warranties 
// of merchantability and fitness for a particular purpose. In no event shall the 
// authors or copyright holders be liable for any claim, damages, or other liability, 
// whether in an action of contract, tort, or otherwise, arising from, out of, 
// or in connection with the software or the use or other dealings in the software.

targetScope = 'subscription'

param actionGroups_name string = 'SvcHlthAG' //cannot be longer than 12 characters
param activityLogAlerts_name string = 'SvcHlthActivityLogAlert' //cannot be longer than 64 once subscriptionId is appended
param emailAddress string = 'user@domain.com' //update with your email address
param resourceGroupName string = 'rg-svchealthalerts' //update with your resource group name
param location string = 'eastus' //update with your location

resource myResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module actionGroupsModule 'actionGroups.bicep' = {
  name: 'actionGroupsModule'
  scope: myResourceGroup
  params: {
    actionGroups_name: actionGroups_name
    emailAddress: emailAddress
  }
}

module activityLogAlertModule 'activityLogAlert.bicep' = {
  name: '${activityLogAlerts_name}-${subscription().subscriptionId}'
  scope: myResourceGroup
  params: {
    activityLogAlerts_name: activityLogAlerts_name
    actionGroupId: actionGroupsModule.outputs.actionGroups_name_resource_id
  }
}
