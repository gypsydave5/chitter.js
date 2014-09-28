process.env.NODE_ENV = 'test'
expect = require('chai').expect
server = require('../../start')
Browser = require('zombie')

describe 'the homepage', ->
    browser = null;

    before ->
        browser = new Browser {
            site: 'http://localhost:3000'
        }

    before (done) ->
        browser.visit '/', done

    it "Has the word 'Chitter' as a title", ->
        expect(browser.text('h1')).to.eq "Chitter"

    it "Has a log in buton", ->
        expect(browser.text('button#log_in')).to.eq "Log in"
