mongoose = require 'mongoose'

Schema = mongoose.Schema

LogSchema = new Schema
  name:
    type: String
    required: true
  type:
    type: String
    required: true
  value:
    type: Number
    required: true
  created:
    type: Date
    default: Date.now

# Massage data prior to injection
LogSchema.pre 'save', (next) ->
  log = this
#  log.value = override
  next()


# Use the schema to register a model with MongoDb
mongoose.model('Log', LogSchema)
Log = mongoose.model('Log')