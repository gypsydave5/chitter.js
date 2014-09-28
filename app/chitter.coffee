app = require('express')()
server = require('http').Server(app)

app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

app.get '/', (request, response)->
    response.render("index")

app.get '/user/new', (request, response)->
    response.render("user_new")

module.exports = server