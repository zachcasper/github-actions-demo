// Import the set of Radius resources (Applications.*) into Bicep
extension radius

@description('The app ID of your Radius Application. Set automatically by the rad CLI.')
param application string
param environment string

resource gateway 'Applications.Core/gateways@2023-10-01-preview' = {
  name: 'gateway'
  properties: {
    application: application
    routes: [
      {
        path: '/'
        destination: 'http://productpage:9080'
      }
    ]
  }
}

resource productpage 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'productpage'
  properties: {
    application: application
    environment: environment
    container: {
      image: 'docker.io/istio/examples-bookinfo-productpage-v1:1.20.2'
      ports: {
        web: {
          containerPort: 9080
        }
      }
    }
    connections: {
      reviewsv1: {
        source: reviewsv1.id
      }
      reviewsv2: {
        source: reviewsv2.id
      }
      reviewsv3: {
        source: reviewsv3.id
      }
      details: {
        source: details.id
      }
    }
  }
}

resource ratings 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'ratings'
  properties: {
    application: application
    environment: environment
    container: {
      image: 'docker.io/istio/examples-bookinfo-ratings-v1:1.20.2'
      ports: {
        web: {
          containerPort: 9080
        }
      }
    }
  }
}

resource details 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'details'
  properties: {
    application: application
    environment: environment
    container: {
      image: 'docker.io/istio/examples-bookinfo-details-v1:1.20.2'
      ports: {
        web: {
          containerPort: 9080
        }
      }
    }
  }
}

resource reviewsv1 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'reviewsv1'
  properties: {
    application: application
    environment: environment
    container: {
      image: 'docker.io/istio/examples-bookinfo-reviews-v1:1.20.2'
      ports: {
        web: {
          containerPort: 9080
        }
      }
    }
  }
}

resource reviewsv2 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'reviewsv2'
  properties: {
    application: application
    environment: environment
    container: {
      image: 'docker.io/istio/examples-bookinfo-reviews-v2:1.20.2'
      ports: {
        web: {
          containerPort: 9080
        }
      }
    }
    connections: {
      ratings: {
        source: ratings.id
      }
    }
  }
}

resource reviewsv3 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'reviewsv3'
  properties: {
    application: application
    environment: environment
    container: {
      image: 'docker.io/istio/examples-bookinfo-reviews-v3:1.20.2'
      ports: {
        web: {
          containerPort: 9080
        }
      }
    }
    connections: {
      ratings: {
        source: ratings.id
      }
    }
  }
}

