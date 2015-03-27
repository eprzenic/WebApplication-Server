log = require.main.require('./app/controllers/log')

module.exports = (router) ->
  index = (req, res) ->
    search = req.params.search
    search = search.replace(':','')
    options = search.split('..')

    log.collection(options[0], (docs) ->
      res.render('log/index', {
          title: 'Log',
          logs : docs
        }
      )
    )

  router.get '/log:search', index