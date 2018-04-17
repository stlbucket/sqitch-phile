const clog = require('fbkt-clog')
const apolloClient = require('../../../apolloClient')
const gql = require('graphql-tag')

const mutation = gql`
mutation BuildLocation(
  $name: String!
  $address1: String!
  $address2: String!
  $city: String!
  $state: String!
  $zip: String!
  $lat: String!
  $lon: String!
) {
  buildLocation(input: {
    _name: $name
    _address1: $address1
    _address2: $address2
    _city: $city
    _state: $state
    _zip: $zip
    _lat: $lat
    _lon: $lon
  }) {
    location {
      id
      name
      address1
      address2
      city
      state
      zip
      lat
      lon
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
          return result.data.buildLocation.location
        })
    })
}

module.exports = doGraphql