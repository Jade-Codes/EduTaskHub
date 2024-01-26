param webAppName string = 'theedutaskhub' 
param imageName string = 'edutaskhub'
param sku string = 'F1'
param location string = resourceGroup().location // Location for all resources
param repositoryUrl string = 'https://github.com/jade-codes/edutaskhub'
param branch string = 'main'
var appServicePlanName = toLower('AppServicePlan-${webAppName}')
var webSiteName = toLower('wapp-${webAppName}')

param repoUsername string
@secure()
param repoToken string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01' = {
  parent: appService
  name: 'web'
  properties: {
    branch: branch
    gitHubActionConfiguration: {
      containerConfiguration: {
        imageName: imageName
        password: repoToken
        serverUrl: 'ghcr.io'
        username: repoUsername
      }
      generateWorkflowFile: true
      isLinux: true
    }
    isGitHubAction: true
    isManualIntegration: false
    isMercurial: false
    repoUrl: repositoryUrl
  }
}
