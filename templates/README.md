# Linked Templates

Use [linked templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates?tabs=azure-powershell#linked-template) 
to merge App Service app settings from multiple configuration files.

```bash

az group create -n cdw-webapp-20210330 -l westus2

az deployment group create \
--resource-group cdw-webapp-20210330 \
--template-uri https://raw.githubusercontent.com/cwiederspan/learn-arm-templates/master/templates/main.json \
--parameters base_name=cdw-webapp-20210330

```
