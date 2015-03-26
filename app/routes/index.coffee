module.exports = (router) ->
  # home page
  index = (req, res) ->
    res.render('index', title: 'Testing')

  router.get '/', index
