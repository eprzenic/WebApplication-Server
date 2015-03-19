# CRUD operations with controller

log = require.main.require('./app/controllers/log')

# api/log?name=test&value=0&type=thisorthat
exports.add = (req, res) ->
  response = log.add(req.query.name, req.query.type, req.query.value)
  res.send(response)

###
app.get('/log/:name', function(req, res) {
  res.send('name ' + req.params.name);
});
###

# {"name":"foo","color":"red"}  <-- JSON encoding
exports.update = (req, resp) ->
  derp = req.body.derp
  slurp = req.body.slurp

exports.new = (req, resp) ->
  console.log(req.body) # JSON
  res.send('OK')

exports.remove = (req, resp) ->
  console.log(req.body) # JSON
  res.send('OK')