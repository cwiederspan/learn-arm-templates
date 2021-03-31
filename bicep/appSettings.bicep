param appServiceName string

resource appServiceSettings 'Microsoft.Web/sites/config@2020-06-01' = {
  name: '${appServiceName}/appsettings'
  properties: {
    Custom1Setting1: 'value1'
    Custom1Setting2: 'value2'
  }
}
