const clog = require('fbkt-clog')
const apolloClient = require('../../../apolloClient')
const gql = require('graphql-tag')

const mutation = gql`
mutation BuildContact(
  $firstName: String!
  $lastName: String!
  $email: String!
  $cellPhone: String!
  $officePhone: String!
  $title: String!
  $nickname: String!
  $externalId: String!
  $organizationId: UUID!
) {
  buildContact(input: {
    _firstName: $firstName
    _lastName: $lastName
    _email: $email
    _cellPhone: $cellPhone
    _officePhone: $officePhone
    _title: $title
    _nickname: $nickname
    _externalId: $externalId
    _organizationId: $organizationId
  }) {
    contact {
      id
      firstName
      lastName
      email
      cellPhone
      officePhone
      title
      nickname
      externalId
      appTenantId
      organizationId
      organization: organizationByOrganizationId {
        id
        name
        appTenantId
      }
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
          return result.data.buildContact.contact
        })
    })
}

module.exports = doGraphql