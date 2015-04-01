fs = require('fs')
path = require('path')
dir = require('node-dir')

module.exports =
  getAllSubDirectories: (dirPath, done) ->
    # windows paths verse unix fixes
    dirPath = dirPath.replace(/\\/g, String.fromCharCode(47))
    dir.subdirs(dirPath, (err, subDirs) ->
      _.forEach(subDirs, (s, index) ->
        temp = s.replace(/\\/g, String.fromCharCode(47))
        temp = temp.replace(dirPath,"")
        subDirs[index] = temp
      )
      done(err, subDirs)
    )