var app = require('express')()
var server = require('http').Server(app)

app.set('view engine', 'jade')
app.set('views', __dirname + '/views')

app.get('/', function (request, response) {
    response.render("index")
});

module.exports = server