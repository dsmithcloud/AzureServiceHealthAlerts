// DISCLAIMER: This code is provided "as is" without warranty of any kind, 
// either express or implied, including but not limited to the implied warranties 
// of merchantability and fitness for a particular purpose. In no event shall the 
// authors or copyright holders be liable for any claim, damages, or other liability, 
// whether in an action of contract, tort, or otherwise, arising from, out of, 
// or in connection with the software or the use or other dealings in the software.

param actionGroups_name string //passed in from parent template
param emailAddress string //passed in from parent template

resource actionGroups_name_resource 'microsoft.insights/actionGroups@2019-06-01' = {
  name: actionGroups_name
  location: 'Global'
  properties: {
    groupShortName: actionGroups_name
    enabled: true
    emailReceivers: [
      {
        name: actionGroups_name
        emailAddress: emailAddress
      }
    ]
    smsReceivers: []
    webhookReceivers: []
  }
}

output actionGroups_name_resource_id string = actionGroups_name_resource.id
