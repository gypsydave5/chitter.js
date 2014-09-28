router = require('express').Router()

router.get '/new', (request, response)->
  response.render("user/new")

router.post '/new', (request, response)->
  session = request.session
  session.username = request.body.username
  session.save
  response.redirect("/")

module.exports = router
