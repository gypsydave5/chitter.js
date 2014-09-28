var app = require('express')()
var server = require('http').Server(app)

app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

app.get('/', function (request, response) {
    response.render("index")
});

module.exports = server