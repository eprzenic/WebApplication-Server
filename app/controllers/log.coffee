mongoose = require('mongoose')
Log = mongoose.model('Log')

exports.add = (name, type, value) ->
  log = new Log()
  log.name = name
  log.type = type
  log.value = value

  log.save (err) ->
    if err
      console.log(err)
      return 'NOK'
    return 'OK'

exports.collection = (name, callback) ->
  now = new Date()
  start = new Date(now)
  numDays = 1
  start.setDate(start.getDate - numDays)

  Log.find({'name': name, 'created': {$gt: start }},{}, (e, doc) ->
    callback(doc)
  )