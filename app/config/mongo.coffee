# Init and register mongo schemas
mongoose = require('mongoose')

config = require.main.require('./config.json')
mongoose.connect(config.MONGO.CONNECTION)

# models
require.main.require('./app/models/log')