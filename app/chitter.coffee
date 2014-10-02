app = require('express')()
server = require('http').Server(app)
require './model/db.coffee'
bodyParser = require 'body-parser'

session = require 'express-session'

app.set('views', __dirname + '/views')
app.set 'view engine', 'jade'

app.use bodyParser.json()
app.use bodyParser.urlencoded({extended: true})

#apply sessions before routes declared or they can't use them
app.use(session {
  secret: 'chitter zombie',
  saveUninitialized: true,
  resave: true
  }
)

#routes go here
home = require './routes/index.coffee'
user = require './routes/user.coffee'

app.use '/', home
app.use '/user', user

module.exports = server