const expect = require('chai').expect
const clog = require('fbkt-clog')
const apolloClient = require('../../apolloClient')
const readFileSync = require('fs').readFileSync
const counterUpEvt = readFileSync(__dirname + '/../../gql/ex/mutation/counterUpEvt.graphql', 'utf8')
//
// // const allLocations = require('../../gql/query/allLocations')
//
describe('ex-counter-evt', function (done) {

  it('should call counterUpEvt mutation', function (done) {
    apolloClient.setGraphqlEndpoint('http://localhost:5000/graphql')
    apolloClient.setCredentials({
      username: 'testy.mctesterson@testyorg.org',
      password: 'badpassword'
    })

    apolloClient.mutate({
      mutation: counterUpEvt,
      variables: {},
      resultPath: 'counterUpEvt.counterEvt'
    })
      .then(counterEvt => {
        // clog('counterEvt', counter)
        expect(counterEvt).to.be.an('object')
        expect(counterEvt.currentValue > 0).to.equal(true)
        done()
      })
      .catch(error => {
        done(error)
      })
  })

})

