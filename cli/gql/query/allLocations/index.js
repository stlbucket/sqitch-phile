const clog = require('fbkt-clog')
const apolloClient = require('../../../apolloClient')
const gql = require('graphql-tag')

const query = gql`
query {
  allLocations {
    nodes {
      id
      name
      address1
      address2
      city
      state
      zip
      lat
      lon
      appTenantId
    }
  }
}`

function allLocations(variables){
  return apolloClient.connect()
    .then(client => {
      return client.query({
          query: query,
          variables: variables || {}
        })
        .then(result => {
          return result.data.allLocations.nodes
        })
    })
}

module.exports = allLocations