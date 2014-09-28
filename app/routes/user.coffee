router = require('express').Router()

router.get '/new', (request, response)->
  response.render("user/new")

router.post '/new', (request, response)->
  response.redirect("/")

module.exports = router
