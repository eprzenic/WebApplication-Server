# register routes

express = require('express')
router = express.Router()

# middleware specific to this router
router.use( (req, res, next) ->
  console.log('Time: ', Date.now())
  next()
)

# root
root = require.main.require('./app/routes')
router.get '/', root.index

# api
api = require.main.require('./app/routes/api')
router.get '/api', api.raw

# api/log
log = require.main.require('./app/routes/api/log')
logBase = '/api/log'

# Note: GET should not be used for create, but
# tool used designed for only this type of request
router.get logBase, log.add
router.put logBase, log.new
router.post logBase, log.update
router.delete logBase, log.remove


module.exports = router