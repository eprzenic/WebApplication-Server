# Init and register mongo schemas
mongoose = require('mongoose')

config = require.main.require('./config/environment.json')

db = mongoose.connection

db.on('error', console.error)
db.once('open', () ->
  # Create your schemas and models here.
)

mongoose.connect(config.MONGO.CONNECTION)

# models
require.main.require('./app/models/log')