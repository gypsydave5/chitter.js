process.env.NODE_ENV = 'test'
expect = require('chai').expect
server = require('../../start')
mongoose = require 'mongoose'
Browser = require('zombie')

describe 'the homepage', ->
  browser = null

  before (done) ->
    browser = new Browser {
      site: 'http://localhost:3000'
    }
    mongoose.connection.db.executeDbCommand { dropDatabase:1  }, (err, result) ->
      mongoose.connection.close done

  beforeEach (done) ->
    browser.visit '/', ->
      mongoose.connect 'mongodb://localhost/chitter-test', done

  afterEach (done) ->
    mongoose.connection.db.executeDbCommand { dropDatabase:1  }, (err, result) ->
      mongoose.connection.close done


  it "Has the word 'Chitter' as a title", ->
    expect(browser.text('h1')).to.eq "Chitter"

  it "Has a log in button", ->
    expect(browser.text('a#log_in')).to.eq "Log in"

  it "Has a sign up button", ->
    expect(browser.text('a#sign_up')).to.eq "Sign up"

  it "The log in button takes you to the log in page", ->
    browser.clickLink 'a#log_in'
    expect(browser.location.pathname).to.eq "/session/new"

  it "The sign up button takes you to the sign up page", ->
    browser.clickLink 'a#sign_up'
    expect(browser.location.pathname).to.eq "/user/new"


