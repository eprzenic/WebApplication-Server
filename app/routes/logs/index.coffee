log = require.main.require('./app/controllers/logs')

module.exports = (router) ->
  index = (req, res) ->
    search = req.params.search
    search = search.replace(':','')
    options = search.split('..')
    log.collection(options[0], (docs) ->
      res.render('logs/index', {
          title: 'Logs',
          logs : docs
        }
      )
    )

  router.get '/logs:search', index