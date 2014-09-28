router = require('express').Router()

router.get '/', (request, response)->
  response.render "index", {username : request.session.username }

module.exports = router
