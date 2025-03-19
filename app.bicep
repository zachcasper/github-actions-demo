// Update 2 to trigger GitHub Action

extension radius

resource environment 'Applications.Core/environments@2023-10-01-preview' existing = {
  name: 'default'
}

resource demo 'Applications.Core/applications@2023-10-01-preview' = {
  name: 'demo'
  properties: {
    environment: environment.id
  }
}

resource frontend 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'frontend'
  properties: {
    application: demo.id
    container: {
      image: 'ghcr.io/radius-project/samples/demo:latest'
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
  }
}

