app = require('express')()
server = require('http').Server(app)

app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

app.get '/', (request, response)->
    response.render("index")

module.exports = server