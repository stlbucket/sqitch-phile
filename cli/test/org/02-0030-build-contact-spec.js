const expect = require('chai').expect
const clog = require('fbkt-clog')
const apolloClient = require('../../apolloClient')
const readFileSync = require('fs').readFileSync
const currentAppUserContact = readFileSync(__dirname + '/../../gql/org/mutation/currentAppUserContact.graphql', 'utf8')
const buildContact = readFileSync(__dirname + '/../../gql/org/mutation/buildContact.graphql', 'utf8')
//
// // const allLocations = require('../../gql/query/allLocations')
//
describe('org', function(done){

  it('should build a new contact for current user organization', function (done) {
    apolloClient.setGraphqlEndpoint('http://localhost:5000/graphql')
    apolloClient.setCredentials({
      username: 'testy.mctesterson@testyorg.org',
      password: 'badpassword'
    })

    apolloClient.mutate({
      mutation: currentAppUserContact,
      variables: {},
      resultPath: 'currentAppUserContact.contact'
    })
      .then(userContact => {
        return apolloClient.mutate({
          mutation: buildContact,
          variables: {
            firstName: 'tony',
            lastName: 'tiger',
            email: 'tonytiger@testyorg.org',
            cellPhone: '555.555.5555',
            officePhone: '',
            title: 'chief sugar shill',
            nickname: 'so great',
            externalId: '',
            organizationId: userContact.organization.id
          },
          resultPath: 'buildContact.contact'
        })
      })
      .then(contact => {
        // clog('contact', contact)
        expect(contact).to.be.an('object')
        expect(contact.email).to.equal('tonytiger@testyorg.org')
        done()
      })
      .catch(error => {
        done(error)
      })
  })

  it('should get all contacts for current user', function (done) {
    apolloClient.setGraphqlEndpoint('http://localhost:5000/graphql')
    apolloClient.setCredentials({
      username: 'testy.mctesterson@testyorg.org',
      password: 'badpassword'
    })

    apolloClient.mutate({
      mutation: currentAppUserContact,
      variables: {},
      resultPath: 'currentAppUserContact.contact'
    })
      .then(contact => {
        expect(contact).to.be.an('object')
        expect(contact.email).to.equal('testy.mctesterson@testyorg.org')
        done()
      })
      .catch(error => {
        done(error)
      })
  })

})

