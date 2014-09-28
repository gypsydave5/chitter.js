process.env.NODE_ENV = 'test'
expect = require('chai').expect
server = require('../../start')
Browser = require('zombie')

describe 'the sign up page', ->
  browser = null

  before ->
    browser = new Browser {
      site: 'http://localhost:3000'
    }

  beforeEach (done) ->
    browser.visit '/user/new', done

  it "Has 'Chitter' as a title", ->
    expect(browser.text('h1')).to.eq "Chitter"

  context "submitting a form", ->

    it "Signing up to Chitter", ->
      browser.fill("username", "ash").
        fill("email_address", "ash@evildead.com").
        fill("password", "thisismyboomstick").
        fill("password_confimation", "thisismyboomstick").
        pressButton "submit", ->
          expect(browser.location.pathname).to.eq "/user/new"
          expect(browser.text('#username')).to.eq "Hi ash"
