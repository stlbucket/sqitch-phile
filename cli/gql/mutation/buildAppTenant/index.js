const clog = require('fbkt-clog')
const apolloClient = require('../../../apolloClient')
const gql = require('graphql-tag')

const mutation = gql`
mutation BuildAppTenant(
  $name: String!
  $identifier: String!
){
  buildAppTenant(input: {
    _name: $name
    _identifier: $identifier
  }) {
    appTenant {
      id
      name
      identifier
    }
  }
}
`

function buildAppTenant(variables){
  return apolloClient()
    .then(client => {
      return client.mutate({
          mutation: mutation,
          variables: variables
        })
        .then(result => {
          clog('result', result)
          return result.data.buildAppTenant.appTenant
        })
    })
}

module.exports = buildAppTenant