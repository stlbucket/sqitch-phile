const expect = require('chai').expect
const clog = require('fbkt-clog')
const apolloClient = require('../../apolloClient')
const currentAppUserContact = require('../../gql/mutation/currentAppUserContact')
const buildContact = require('../../gql/mutation/buildContact')
// const allContacts = require('../../gql/query/allContacts')

describe('org', function(done){

  it('should get the current user contact info', function (done) {
    apolloClient.setGraphqlEndpoint('http://localhost:5000/graphql')
    apolloClient.setCredentials({
      username: 'testy.mctesterson@testyorg.org',
      password: 'badpassword'
    })

    currentAppUserContact()
      .then(contact => {
        expect(contact).to.be.an('object')
        expect(contact.email).to.equal('testy.mctesterson@testyorg.org')
        done()
      })
      .catch(error => {
        done(error)
      })
  })

  it('should build a new contact for current user organization', function (done) {
    apolloClient.setGraphqlEndpoint('http://localhost:5000/graphql')
    apolloClient.setCredentials({
      username: 'testy.mctesterson@testyorg.org',
      password: 'badpassword'
    })

    currentAppUserContact()
      .then(userContact => {
        // clog('userContact', userContact)
        return buildContact({
          firstName: 'tony',
          lastName: 'tiger',
          email: 'tonytiger@testyorg.org',
          cellPhone: '555.555.5555',
          officePhone: '',
          title: 'chief sugar shill',
          nickname: 'so great',
          externalId: '',
          organizationId: userContact.organization.id
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

    currentAppUserContact()
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

