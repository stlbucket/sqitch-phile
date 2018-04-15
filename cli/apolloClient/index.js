const clog = require('fbkt-clog')
const Promise = require('bluebird')
const ApolloClient = require('apollo-client').ApolloClient
const HttpLink = require('apollo-link-http').HttpLink
const InMemoryCache = require('apollo-cache-inmemory').InMemoryCache
const fetch = require('node-fetch')
const gql = require('graphql-tag')

let _client
let _clientInitializer
const _graphqlEndpoint = 'http://localhost:5000/graphql'// process.env.SORO_QUOTING_API_ENDPOINT

if (_graphqlEndpoint === null || _graphqlEndpoint === undefined || _graphqlEndpoint === '') {
  throw new Error('SORO_QUOTING_API_ENDPOINT process variable must be defined')
}

const _auth = true

const signinUserMutation = gql(`
mutation Authenticate(
  $username: String!
  $password: String!
){
  authenticate(input: {
    _username: $username
    _password: $password
  }) {
    jwtToken
  }
}
`)

function initAuthClient (_username, _password) {

  if (_clientInitializer) {
    return Promise.resolve(_clientInitializer)
  } else {
    const _initClient = new ApolloClient({
      // By default, this client will send queries to the
      //  `/graphql` endpoint on the same host
      link: new HttpLink({uri: _graphqlEndpoint, fetch: fetch}),
      cache: new InMemoryCache()
    })

    const variables = {
      username: _username,
      password: _password
    }

    clog('vars', variables)

    _clientInitializer = _initClient.mutate({
      mutation: signinUserMutation,
      variables: variables
    })
      .then(result => {
        clog('SIGNIN RESULT', result)

        const token = result.data.authenticate.jwtToken

        const headers = {
          'authorization': `Bearer ${token}`
        }

        clog('HEADERS', headers)

        _client = new ApolloClient({
          // By default, this client will send queries to the
          //  `/graphql` endpoint on the same host
          link: new HttpLink({uri: _graphqlEndpoint, fetch: fetch, headers: headers}),
          cache: new InMemoryCache()
        })

        return _client
      })
      .catch(error => {
        clog.error('UNABLE TO AUTH APOLLO CLIENT', {
          error: error,
          username: _username
        })
        throw error
      })

    return Promise.resolve(_clientInitializer)
  }
}

function initNoAuthClient () {
  _client = new ApolloClient({
    // By default, this client will send queries to the
    //  `/graphql` endpoint on the same host
    link: new HttpLink({uri: _graphqlEndpoint, fetch: fetch}),
    cache: new InMemoryCache()
  })

  return Promise.resolve(_client)
}

function getClient () {
  const _username = process.env.USERNAME
  const _password = process.env.PASSWORD

  if (_client) {
    return Promise.resolve(_client)
  } else if (_auth) {
    return initAuthClient(_username, _password)
  // } else {
  //   clog("NO AUTH - THAT'S NOT REALLY COOL")
  //   return initNoAuthClient()
  }
}

module.exports = getClient