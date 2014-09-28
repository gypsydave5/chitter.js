require('coffee-script/register')
chitter = require('./app/chitter')

var port = process.env.port || 3000

var server = chitter.listen(port, function() {
    console.log("Chitter server started on port " + port)
});

module.exports = server
