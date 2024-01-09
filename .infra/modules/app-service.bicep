param webAppName string
param sku string = 'F1' 
param location string = 'westus2'
param repositoryUrl string
param branch string = 'main'
param imageName string
param serverUrl string
param repoUsername string
@secure()
param repoToken string

var appServicePlanName = toLower('AppServicePlan-${webAppName}')
var webSiteName = toLower(webAppName)
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
  tags: {
    tag1: 'Hi'
  }
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01' = {
  parent: appService
  name: 'web'
  properties: {
    branch: branch
    deploymentRollbackEnabled: false
    gitHubActionConfiguration: {
      containerConfiguration: {
        imageName: imageName
        password: repoToken
        serverUrl: serverUrl
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
