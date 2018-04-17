const clog = require('fbkt-clog')
const apolloClient = require('../../../apolloClient')
const gql = require('graphql-tag')

const mutation = gql`
mutation BuildTenantOrganization(
  $name: String!
  $identifier: String!
  $primaryContactFirstName: String!
  $primaryContactLastName: String!
  $primaryContactEmail: String!
){
  buildTenantOrganization(input: {
    _name: $name
    _identifier: $identifier
    _primaryContactFirstName: $primaryContactFirstName
    _primaryContactLastName: $primaryContactLastName
    _primaryContactEmail: $primaryContactEmail
  }) {
    organization {
      id
      name
    }
  }
}
`

function doGraphql(variables){

  return apolloClient.connect()
    .then(client => {
      return client.mutate({
          mutation: mutation,
          variables: variables
        })
        .then(result => {
          // clog('result', result)
          return result.data.buildTenantOrganization.organization
        })
        .catch(error => {
          clog('BuildTenantOrganization ERROR', error)
          throw error
        })
    })
}

module.exports = doGraphql