router = require('express').Router()

router.get '/new', (request, response)->
  response.render("user/new")

module.exports = router
