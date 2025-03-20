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

resource gateway 'Applications.Core/gateways@2023-10-01-preview' = {
  name: 'gateway'
  properties: {
    application: demo.id
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
    application: demo.id
    environment: environment.id
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
    application: demo.id
    environment: environment.id
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
    application: demo.id
    environment: environment.id
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
    application: demo.id
    environment: environment.id
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
    application: demo.id
    environment: environment.id
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
    application: demo.id
    environment: environment.id
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

