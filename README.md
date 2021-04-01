```bash

BASE_NAME=cdw-webapp-20210330
LOCATION=westus2

az group create -n $BASE_NAME -l $LOCATION



az deployment group validate \
--resource-group $BASE_NAME \
--template-file main.json \
--parameters base_name=$BASE_NAME

az deployment group create \
--name $BASE_NAME \
--resource-group $BASE_NAME \
--template-file main.json \
--parameters base_name=$BASE_NAME



az deployment group validate \
--resource-group $BASE_NAME \
--template-uri https://raw.githubusercontent.com/cwiederspan/learn-arm-templates/master/templates/main.json \
--parameters base_name=$BASE_NAME

az deployment group create \
--resource-group $BASE_NAME \
--template-uri https://raw.githubusercontent.com/cwiederspan/learn-arm-templates/master/templates/main.json \
--parameters base_name=$BASE_NAME




az deployment group create \
--name $BASE_NAME-bicep \
--resource-group $BASE_NAME \
--template-file main.bicep \
--parameters base_name=$BASE_NAME

```
