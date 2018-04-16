const expect = require('chai').expect
const clog = require('fbkt-clog')
const apolloClient = require('../../apolloClient')
const buildLocation = require('../../gql/mutation/buildLocation')
const allLocations = require('../../gql/query/allLocations')

describe('org', function(done){
  it('should build a location', function (done) {
    apolloClient.setGraphqlEndpoint('http://localhost:5000/graphql')
    apolloClient.setCredentials({
      username: 'testy.mctesterson@testyorg.org',
      password: 'badpassword'
    })

    buildLocation({
      name: 'Test Tenant Org Location'
      , address1: 'blah'
      , address2: 'glarn'
      , city: 'yon'
      , state: 'agitated'
      , zip: 'none'
      , lat: ''
      , lon: ''
    })
      .then(location => {
        // clog('location', location)
        expect(location).to.be.an('object')
        expect(location.name).to.equal('Test Tenant Org Location')
        done()
      })
      .catch(error => {
        done(error)
      })
  })

  it('should build a location for a second tenant', function (done) {
    apolloClient.setGraphqlEndpoint('http://localhost:5000/graphql')
    apolloClient.setCredentials({
      username: 'peter.testaroo@testyorg.org',
      password: 'badpassword'
    })

    buildLocation({
      name: 'Test Tenant Org 1 Location'
      , address1: 'blahs'
      , address2: 'glarns'
      , city: 'yons'
      , state: 'agitateds'
      , zip: 'nones'
      , lat: ''
      , lon: ''
    })
      .then(location => {
        // clog('location', location)
        expect(location).to.be.an('object')
        expect(location.name).to.equal('Test Tenant Org 1 Location')
        return allLocations()
      })
      .then(locations => {
        // clog('loc', locations)
        expect(locations.length).to.equal(1)
        done()
      })
      .catch(error => {
        done(error)
      })
  })

})

