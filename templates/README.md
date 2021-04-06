# Linked Templates

Use [linked templates](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates?tabs=azure-powershell#linked-template) 
to merge App Service app settings from multiple configuration files.

## Concept

The idea here is that I need to create an App Service using a central, governed template [main.json](main.json) that includes
some common, baseline app settings, but also need to add environment or app-specific app settings via an external
[appsettings-prod.json](appsettings-prod.json) file.

## Testing

```bash

az group create -n cdw-webapp-20210406 -l westus2

az deployment group validate \
--resource-group cdw-webapp-20210406 \
--template-uri https://raw.githubusercontent.com/cwiederspan/learn-arm-templates/master/templates/main.json \
--parameters base_name=cdw-webapp-20210406

az deployment group create \
--resource-group cdw-webapp-20210406 \
--template-uri https://raw.githubusercontent.com/cwiederspan/learn-arm-templates/master/templates/main.json \
--parameters base_name=cdw-webapp-20210406

```

## Further Reading

* [Blob Post](https://kalcik.net/2019/11/21/merge-azure-app-service-app-settings-in-arm-template/)
* [Stack Overflow](https://stackoverflow.com/questions/51392382/arm-template-concatenate-objects)
