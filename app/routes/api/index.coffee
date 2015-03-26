module.exports = (router) ->

  raw = (req, res) ->
    console.log req
    #  console.log res
    res.send('Hello Raw World!')

  router.get '/api', raw