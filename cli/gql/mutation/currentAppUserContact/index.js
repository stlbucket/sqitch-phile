const clog = require('fbkt-clog')
const apolloClient = require('../../../apolloClient')
const gql = require('graphql-tag')

const mutation = gql`
mutation CurrentAppUserContact{
	currentAppUserContact(input:{}) {
    contact {
      id
      lastName
      firstName
      email
      organization: organizationByOrganizationId {
        id
        name
        externalId
        appTenantId
      }
    }
  }
}`

function doGraphQL(variables){
  return apolloClient.connect()
    .then(client => {
      return client.mutate({
          mutation: mutation,
          variables: variables
        })
        .then(result => {
          return result.data.currentAppUserContact.contact
        })
    })
}

module.exports = doGraphQL