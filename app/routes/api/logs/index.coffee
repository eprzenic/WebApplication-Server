# CRUD operations with controller
logs = require.main.require('./app/controllers/logs')

module.exports = (router) ->

  find = (req, res) ->
    response = logs.collection(undefined, (docs) ->
      res.send(docs)
    )

  # api/logs?name=test&value=0&type=thisorthat
  update = (req, res) ->
    response = logs.add(req.query.name, req.query.type, req.query.value)
    res.send(response)

  ###
  app.get('/log/:name', function(req, res) {
    res.send('name ' + req.params.name);
  });
  ###

  # {"name":"foo","color":"red"}  <-- JSON encoding
  create = (req, resp) ->
    console.log(req.body)

  remove = (req, resp) ->
    console.log(req.body) # JSON
    res.send('OK')

  logBase = '/api/logs'
  # Note: GET should not be used for create, but...
  # tool used designed for only this type of request
  router.get logBase, find
  router.put logBase, update
  router.post logBase, create
  router.delete logBase, remove