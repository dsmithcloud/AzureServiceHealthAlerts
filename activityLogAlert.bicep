// DISCLAIMER: This code is provided "as is" without warranty of any kind, 
// either express or implied, including but not limited to the implied warranties 
// of merchantability and fitness for a particular purpose. In no event shall the 
// authors or copyright holders be liable for any claim, damages, or other liability, 
// whether in an action of contract, tort, or otherwise, arising from, out of, 
// or in connection with the software or the use or other dealings in the software.

param activityLogAlerts_name string //passed in from parent template
param actionGroupId string //passed in from parent template

var alertScope = '/subscriptions/${subscription().subscriptionId}'

resource activityLogAlert 'microsoft.insights/activityLogAlerts@2017-04-01' = {
  name: '${activityLogAlerts_name}-${subscription().subscriptionId}'
  location: 'Global'
  properties: {
    scopes: [
      alertScope
    ]
    condition: {
      allOf: [
        {
          field: 'category'
          equals: 'ServiceHealth'
        }
        {
          field: 'properties.incidentType'
          equals: 'Incident'
        }
      ]
    }
    actions: {
      actionGroups: [
        {
          actionGroupId: actionGroupId
          webhookProperties: {}
        }
      ]
    }
    enabled: true
  }
}
