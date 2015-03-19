# GET home page.
exports.index = (req, res) ->
  res.render('index', title: 'Api')

exports.raw = (req, res) ->
  console.log req
#  console.log res
  res.send('Hello Raw World!')