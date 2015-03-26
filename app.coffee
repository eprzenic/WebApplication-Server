# Module Dependencies #
express = require('express')
iced = require("iced-coffee-script")
mongoose = require('mongoose')
http = require('http')
stylus = require('stylus')
nib = require('nib')
path = require('path')
assets = require('connect-assets')
bodyParser = require('body-parser')
morgan = require('morgan')
errorHandler = require('errorhandler')
methodOverride = require('method-override')
serveStatic = require('serve-static')
multer = require('multer')

## Global (visibility)  ##
global._ = require('lodash')

# Create/Setup app instance #
app = express()

# Configuration #
config = require('./config.json')
app.set('port', process.env.PORT || config.SERVER.PORT)

# tell express that we want to use Jade, and where we will keep our views
app.set('views', path.join(__dirname, 'app', 'views'))
app.set('view options',{ locals: { } })
app.set('view engine', 'jade')
#app.locals.<variable/function>

# pass 'middleware' functions for express to use
app.use(morgan('dev'))
app.use(methodOverride())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(multer())

app.use(errorHandler())

app.use( stylus.middleware(
  src: __dirname + '/app/views/stylus'
  dest: __dirname + '/public'
  debug: true
  compile: (str, path) ->
    stylus(str).set('filename', path).set('compress').use(nib())
  )
)

app.use(express.static(path.join(__dirname, 'public')))

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

# Mongo Init #
require('./app/config/mongo')

# Routing #
router = require('./app/routes/router')
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