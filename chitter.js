var app = require('express')()
var server = require('http').Server(app)

app.set('view engine', 'jade')

app.get('/', function (request, response) {
    response.send("<h1>Chitter</h1>")
});

module.exports = server