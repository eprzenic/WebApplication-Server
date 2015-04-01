# CRUD operations with controller
log = require.main.require('./app/controllers/log')

module.exports = (router) ->

  read = (req, res) ->
    response = log.collection(undefined, (docs) ->
      res.send(docs)
    )

  # api/logs?name=test&value=0&type=thisorthat
  create = (req, res) ->
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

  remove = (req, resp) ->
    console.log(req.body) # JSON
    res.send('OK')

  logBase = '/api/logs'
  # Note: GET should not be used for create, but...
  # tool used designed for only this type of request
  router.get logBase, read
  router.put logBase, create
  router.post logBase, update
  router.delete logBase, remove