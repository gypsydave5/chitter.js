mongoose = require 'mongoose'
dbURI = null

if process.env.NODE_ENV == 'test'
  dbURI = 'mongodb://localhost/chitter-test'
else if process.env.NODE_ENV == 'staging'
  dbURI = heroku_staging_db_here_please
else if process.env.NODE_ENV == 'production'
  dbURI = heroku_production_db_here_please
else
  dbURI = 'mongodb://localhost/chitter-development'

mongoose.connect(dbURI)

mongoose.connection.on 'connected', ->
    console.log('Mongoose connected to ' + dbURI)

mongoose.connection.on 'error', ->
    console.log('Mongoose connection error: ' + err)

mongoose.connection.on 'disconnected', ->
    console.log('Mongoose disconnected')

gracefulShutdown = (message, callback)->
    mongoose.connection.close ->
        console.log('Mongoose disconnected ' + message)
        callback()

process.once 'SIGUSR2', ->
    gracefulShutdown 'nodemon restart', ->
        process.kill(process.pid, 'SIGUSR2')

process.on 'SIGINT', ->
    gracefulShutdown 'app termination', ->
        process.exit(0)

process.on 'SIGTERM', ->
    gracefulShutdown 'Heroku app shutdown', ->
        process.exit(0)

require './user'
