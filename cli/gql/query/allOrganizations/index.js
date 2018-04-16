const clog = require('fbkt-clog')
const apolloClient = require('../../../apolloClient')
const gql = require('graphql-tag')

const query = gql`
query {
  allOrganizations {
    nodes {
      id
      name
      appTenantId
      thisAppTenantId
    }
  }
}`

function allOrganizations(variables){
  return apolloClient.connect()
    .then(client => {
      return client.query({
          query: query,
          variables: variables || {}
        })
        .then(result => {
          return result.data.allOrganizations.nodes
        })
    })
}

module.exports = allOrganizations