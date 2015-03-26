fs = require('fs')
path = require('path')
dir = require('node-dir')
_ = require('lodash')

module.exports =
  getAllSubDirectories: (dirPath, done) ->
    dir.subdirs(dirPath, (err, subDirs) ->
      _.forEach(subDirs, (s, index) ->
        temp = s.replace(dirPath,"")
        temp = temp.replace(/\\/g, String.fromCharCode(47))
        subDirs[index] = temp
      )
      done(err, subDirs)
    )