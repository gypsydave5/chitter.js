var mongoose = require('mongoose');
var dbURI = 'mongodb://localhost/Loc8r'; //DB connection string
// we can change the connection string based on the NODE_ENV environment
// variable
mongoose.connect(dbURI); //gets passed to mongoose - the default connection
//you could also use named connections for multiple databases


//these are the mongoose connection events, which we can now just link up to the
//app.

mongoose.connection.on('connected', function() {
    console.log('Mongoose connected to ' + dbURI)
})

mongoose.connection.on('error', function(err){
    console.log('Mongoose connection error: ' + err)
})

mongoose.connection.on('disconnected', function() {
    console.log('Mongoose disconnected')
})

// The code below closes the mongoose connection 'gracefully', either on a
// app shutdown event ('SIGINT'), or others. `process.once` gracefully only
// intercepts SIGUSR2 once - it's being used by nodemon and we only want to
// catch it the first time - it can go about its business afer that.

var gracefulShutdown = function(message, callback){
    mongoose.connection.close(function(){
        console.log('Mongoose disconnected ' + message);
        callback();
    });
};

//Each of the Node processes that can stop the app

process.once('SIGUSR2', function(){
    gracefulShutdown('nodemon restart', function(){
        process.kill(process.pid, 'SIGUSR2');
    });
});

process.on('SIGINT', function(){
    gracefulShutdown('app termination', function(){
        process.exit(0);
    });
});

process.on('SIGTERM', function(){
    gracefulShutdown('Heroku app shutdown', function(){
        process.exit(0);
    });
});
