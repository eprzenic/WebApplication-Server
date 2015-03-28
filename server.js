// load initial file for entire application
var coffee = require('iced-coffee-script/register'); // register compiler with nodejs
var app = require('./app/app.coffee'); // startup file

// This bootstraps your Gulp's main file (for coffeescript usage)
require('./gulpfile.js');