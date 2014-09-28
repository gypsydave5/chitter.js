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
        fill("email", "ash@evildead.com").
        fill("password", "thisismyboomstick").
        fill("password_confirmation", "thisismyboomstick").
        pressButton("submit").
        then ->
          expect(browser.text('#username')).to.eq "Hi ash"
          expect(browser.location.pathname).to.eq "/"
