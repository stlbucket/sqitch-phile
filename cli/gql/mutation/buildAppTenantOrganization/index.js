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
      appTenantId
      thisAppTenantId
      appTenant: appTenantByAppTenantId {
        id
        name
      }
      contacts: contactsByOrganizationId {
        nodes {
          id
          email
          firstName
          lastName
          appUserId
          appUser: appUserByAppUserId {
            id
            appTenantId
            username
          }
        }
      }
    }
  }
}
`

function buildAppTenantOrganziation(variables){
  return apolloClient.connect()
    .then(client => {
      return client.mutate({
          mutation: mutation,
          variables: variables
        })
        .then(result => {
          return result.data.buildTenantOrganization.organization
        })
    })
}

module.exports = buildAppTenantOrganziation