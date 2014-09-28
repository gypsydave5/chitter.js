app = require('express')()
server = require('http').Server(app)

#routes go here
home = require('./routes/index.coffee')
user = require('./routes/user.coffee')

app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

app.use('/', home)
app.use('/user', user)

module.exports = server