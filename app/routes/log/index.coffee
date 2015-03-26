log = require.main.require('./app/controllers/log')

module.exports = (router) ->
  index = (req, res) ->
    log.collection( (docs) ->
      res.render('log/index', {
          title: 'Log',
          "logs" : docs
        }
      )
    )

  router.get '/log', index