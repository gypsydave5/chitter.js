express = require('express')
chitter = require('http').Server(express)

var port = process.env.port || 3000

var server = chitter.listen(port, function() {
    console.log("Chitter server started on port " + port)
})

module.exports = server