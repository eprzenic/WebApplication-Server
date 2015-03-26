# register routes

express = require('express')
router = express.Router()

fsWrapper = require.main.require('./app/helpers/fsExtension')

# middleware specific to this router
router.use( (req, res, next) ->
  console.log('Time: ', Date.now())

  # quick-n-dirty add mongo object to each request
  #req.db = db

  next()
)

# load ALL folder'd routes
fsWrapper.getAllSubDirectories(__dirname, (err, results) ->
  if err
    throw err
  require.main.require('./app/routes')(router)
  _.forEach(results, (relativePath) ->
    require.main.require('./app/routes' + relativePath)(router)
  )
)


module.exports = router