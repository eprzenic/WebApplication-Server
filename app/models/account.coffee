mongoose = require('mongoose')
Schema = mongoose.Schema
passportLocalMongoose = require('passport-local-mongoose')

AccountSchema = new Schema
  username: 
    type: String
    required: true
  password: 
    type: String
    required: true

AccountSchema.plugin(passportLocalMongoose)
module.exports = mongoose.model('Account', AccountSchema)