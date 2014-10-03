process.env.NODE_ENV = 'test'
mongoose = require 'mongoose'
user = require '../app/model/user'
require 'mocha-mongoose'
chai = require('chai')
chaiAsPromised = require 'chai-as-promised'
chai.use (chaiAsPromised)
expect = chai.expect
should = chai.should
dbURI = 'mongodb://localhost/chitter-test'

describe 'The User model', ->

  before (done) ->
    mongoose.connect dbURI, ->
      done()

# So this one works - it's using promises to wait for the find to resolve, and then solving it. But it's problematic replicating the test pattern without flling back on a callback.
  it 'starts with no users', ->
    users = user.find().exec()
    expect(users).to.eventually.eql []

# And this one works too - but in an odd way. When it passes it passes, but when it fails it just times out. Sucks.
  it 'saves users', (done) ->
    bob = new user {username: "bob", password: "pisswird"}
    bob.save (error, saved_bob) ->
      done error if error
      expect(saved_bob.username).to.equal "bob"
      expect(saved_bob.password).to.equal "pisswird"
      done()

# Looks like the only way to test for errors!
  it 'does not save when there is no user', (done) ->
    bob = new user {username: "bob" }
    bob.save (error, saved_bob) ->
      expect(error).to.exist
      done()

  it 'does not save when there is no password', (done) ->
    bob = new user {password: "pisswird"}
    bob.save (error, saved_bob) ->
      expect(error).to.exist
      done()

# Shit - this one actually works!
  it 'may even have a custom method to make a new user', (done) ->
    expect((user.new_user "erik", "thedog", done()).username).to.eql "erik"

  #it 'can add a new user', ->
    #user.create {username: "bob", password: "pisswird"}, ->
      #user.find({}, (error, users)->
        #console.log(users)
        #lenny = users.length
        #console.log(lenny)
      #)

  #it 'can add a two new users', ->
    #User.create {username: "bob", password: "pisswird"}, ->
      #User.create {username: "harry", password: "pisswird"}, ->
        #User.find {}, (error, users)->
          #expect(users.length).to.be 1
          #console.log(users)

  #it 'must have a username', ->
    #user = new User {password: "pisswird"}
    #user.save (error, user)->
      #should.exist(error)
      #expect(error.message).to.eq ""

      #expect(user.length).to.eq 1

  #it 'increases the user count by one when a user is created', ->
    #User.count {}, (error, count)->
      #count.should.equal 5

    #bob = new User({username: "bob", password: "passswird"})
    #bob.save

    #User.count {}, (error, count)->
      #if error
        #console.log("FAIL")

      #expect(count).to.be 5
