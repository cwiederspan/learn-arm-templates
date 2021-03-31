param base_name string

resource appServicePlan 'Microsoft.Web/serverfarms@2018-02-01' = {
  name: '${base_name}-plan'
  location: 'West US 2'
  sku: {
    name: 'S1'
    tier: 'Standard'
    size: 'S1'
    family: 'S'
    capacity: 1
  }
  kind: 'app'
  properties: {
    perSiteScaling: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
}

resource appService 'Microsoft.Web/sites@2018-11-01' = {
  name: '${base_name}-app'
  location: 'West US 2'
  kind: 'app'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${base_name}-app.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${base_name}-app.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: appServicePlan.id
    reserved: false
    isXenon: false
    hyperV: false
    siteConfig: {
      appSettings: [
        {
          name: 'EmbeddedSetting1'
          value: 'some random value'
        }
      ]
      connectionStrings: [
        {
          name: 'MyConnectionString'
          connectionString: 'string'
          type: 'Custom'
        }
      ]
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: true
    clientCertEnabled: false
    hostNamesDisabled: false
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    redundancyMode: 'None'
  }
}

resource hostNameBindings 'Microsoft.Web/sites/hostNameBindings@2018-11-01' = {
  name: '${appService.name}/${base_name}-app.azurewebsites.net'
  properties: {
    siteName: appService.name
    hostNameType: 'Verified'
  }
}

resource appServiceConfig 'Microsoft.Web/sites/config@2018-02-01' = {
  name: '${appService.name}/web'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v5.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2019'
    httpLoggingEnabled: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$cdw-armwebapp-20210330-app'
    azureStorageAccounts: {}
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: true
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: true
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    ftpsState: 'AllAllowed'
    reservedInstanceCount: 0
  }
}

module publicIp './appSettings.bicep' = {
  name: 'appSettings'
  params: {
    appServiceName: appService.name
  }
}
