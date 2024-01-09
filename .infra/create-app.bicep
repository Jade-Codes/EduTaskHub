param location string = 'westus'
param repoUsername string

@secure()
param repoToken string

module appService './modules/app-service.bicep' = {
  name: 'EduTaskHubAppService'
  params: {
    imageName: 'edutaskhub'    
    location: location
    repositoryUrl:'https://github.com/jade-codes/edutaskhub'
    repoUsername: repoUsername
    repoToken: repoToken
    serverUrl: 'ghcr.io'
    webAppName: 'theedutaskhub'
  }
}
