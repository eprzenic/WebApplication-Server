# Overview

Gulp, Mongo, IcedCoffeScript (i.e. CoffeeScript), Node (see package.json for many modules), Express, Jade, Stylus (with Nib), Mocha, Chai, Sinon...

A working template/boilerplate/experiment from doing a few hours research and several hours implementing.  Done to get started to make a live tested server application.  This is a first attempt to get a handle in this world, hope you like it.

It was used to simply log information (See my repository SmartThings [DeviceLogging](https://github.com/justinlhudson/SmartThings)) through web api into mongodb with a useless web page for structure and display purposes.

# Structure

## app
#### consists of application code
### assets
#### 3rd party vendor code that requires compilation
- css
  - *.style
- js
  - *.js
- *
### config
#### app options and linking
- mongo
  - connection, model, ...
- router
  - HTTP request/response, ...
- *

### controllers
#### data manipulation with the model's state
- *

### models
#### represents data that handles storage using mongo schemas

### routes
#### determining response to request to a particular endpoint (GET, PUT, PST, DELETE, and so on)

### views
#### manages the display of information from route requested and controller retrieving model

## public
#### compiled/static files server to browser
- images
- html
- *

## tests
#### mocha as test framework, chai for assertion and sinon as spyes/stubs/mocks

## server.js & app.coffee
#### initializes the app and glues everything together

# Development
## run command: 
- **gulp**
### which will lint the app, watch for changes, and start the web server (except for mongod)
- gulpfile.js
  - lint
  - watch
  - server

# Live Running
- npm install, mongo, server!
### Windows
- run.bat
### OSX & Linux
- run.sh
