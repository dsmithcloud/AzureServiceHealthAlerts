# AzureServiceHealthAlerts
Bicep templates to create Azure Service Health Alerts at a subscription scope level. Creates a new resource group, alert group, and the alert.

# Deployment Instructions
```
# Set your tenantId
tenantId="your-tenant-id"

# Get the list of subscriptions for the specified tenantId
subscriptions=$(az account list --tenant $tenantId --query "[].id" -o tsv)

# Loop through each subscription and run the Bicep deployment
for subscription in $subscriptions; do
    az account set --subscription $subscription
    az deployment sub create --location eastus --template-file svchealthalerts.bicep
done
```