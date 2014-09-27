process.env.NODE_ENV = 'test'
var expect = require('chai').expect
var server = require('../../start')
var Browser = require('zombie')

describe('the homepage', function(){
    var browser;

    before(function(){
        browser = new Browser({
            site: 'http://localhost:3000'
        });
    });

    before(function(done) {
        browser.visit('/', done)
    })

    it("Has the word 'Chitter' as a title", function() {
        expect(browser.text('h1')).to.eq("Chitter")
    });

});
