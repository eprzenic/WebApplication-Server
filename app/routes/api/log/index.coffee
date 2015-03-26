# CRUD operations with controller
log = require.main.require('./app/controllers/log')

module.exports = (router) ->
  # api/log?name=test&value=0&type=thisorthat
  add = (req, res) ->
    response = log.add(req.query.name, req.query.type, req.query.value)
    res.send(response)

  ###
  app.get('/log/:name', function(req, res) {
    res.send('name ' + req.params.name);
  });
  ###

  # {"name":"foo","color":"red"}  <-- JSON encoding
  update = (req, resp) ->
    derp = req.body.derp
    slurp = req.body.slurp

  create = (req, resp) ->
    console.log(req.body) # JSON
    res.send('OK')

  remove = (req, resp) ->
    console.log(req.body) # JSON
    res.send('OK')

  logBase = '/api/log'
  # Note: GET should not be used for create, but...
  # tool used designed for only this type of request
  router.get logBase, add
  router.put logBase, create
  router.post logBase, update
  router.delete logBase, remove