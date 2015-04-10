# Module Dependencies #
express = require('express')
iced = require("iced-coffee-script")
mongoose = require('mongoose')
BSON = require('mongodb').BSON
http = require('http')
stylus = require('stylus')
path = require('path')
assets = require('connect-assets')
bodyParser = require('body-parser')
morgan = require('morgan')
errorHandler = require('errorhandler')
methodOverride = require('method-override')
serveStatic = require('serve-static')
multer = require('multer')
cors = require('cors')
helmet = require('helmet')
passport = require('passport')
LocalStrategy = require('passport-local').Strategy
ClientPasswordStrategy = require('passport-oauth2-client-password').Strategy
passportLocalMongoose = require('passport-local-mongoose')
oauth2orize = require('oauth2orize')

## Global (visibility)  ##
global._ = require('lodash')

# Create/Setup app instance #
app = express()

# Configuration #
config = require.main.require('./config/environment.json')
app.set('port', process.env.PORT || config.SERVER.PORT)

# tell express that we want to use Jade, and where we will keep our views
app.set('views', path.join(__dirname, 'templates'))
app.set('view options',{ locals: { } })
app.set('view engine', 'jade') # Note: replaced by jade-coffeescript
#app.locals.<variable/function>

# pass 'middleware' functions for express to use
app.use(cors())
app.use(helmet.contentSecurityPolicy({
    defaultSrc: ["'self'"],
    scriptSrc: ["'self'"],
    styleSrc: ["'self'"],
    imgSrc: ["'self'"],
    connectSrc: ["'self'"],
    fontSrc: ["'self'"],
    objectSrc: ["'none'"],
    mediaSrc: ["'self'"],
    frameSrc: ["'none'"],
    # reportUri: '/report-violation',
    reportOnly: false, # set to true if you only want to report errors
    setAllHeaders: false, # set to true if you want to set all headers
    safari5: false # set to true if you want to force buggy CSP in Safari 5
}))
app.use(morgan('dev'))
app.use(methodOverride())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(multer())

app.use(errorHandler())

app.use( stylus.middleware(
  src: __dirname + '/styles/stylus'
  dest: __dirname + '../dist'
  debug: true
  compile: (str, path) ->
    stylus(str).set('filename', path).set('compress').use()
  )
)

app.use(express.static(path.join(__dirname, '../dist')))

# Setup which compiler to use for js files
icedCompiler =
  match: /\.js$/,
  compileSync: (sourcePath, source) ->
    try
      jsSrc = iced.compile(source, filename: sourcePath, runtime: "window")
    catch ex
      console.log("Error Compiling '#{sourcePath}':\r\n" + ex)
    return jsSrc

app.use assets(
  src: "#{__dirname}/app/assets",
  jsCompilers:
    coffee: icedCompiler
)

# Mongo init #
require.main.require('./app/helpers/mongo')

# passport config
app.use(passport.initialize());
app.use(passport.session());

Account = require('./models/account')
passport.use(new LocalStrategy(Account.authenticate()))
passport.serializeUser(Account.serializeUser())
passport.deserializeUser(Account.deserializeUser())

# passport oauth2
#ToDo: https://github.com/jaredhanson/oauth2orize/tree/master/examples/express2
# http://aleksandrov.ws/2013/09/12/restful-api-with-nodejs-plus-mongodb/
https://github.com/jaredhanson/oauth2orize/tree/master/examples/express2
oauth = oauth2orize.createServer()
passport.use(new ClientPasswordStrategy((clientId, clientSecret, done) ->
  console.log("*** ClientPasswordStrategy")
  client = new
    clientId = "..."
    clientSecret = "..."
  done(null, client)
))

# Routing #
router = require.main.require('./app/router')
app.use('/', router)

server = require('http').createServer(app)
io = require('socket.io')(server)

io.on('connection', () ->
  console.log('connection')
)

# nodejs
server.listen(app.get('port'), () ->
  console.log('Node listening on port ' + app.get('port'))
)

# export app object
module.exports = app;