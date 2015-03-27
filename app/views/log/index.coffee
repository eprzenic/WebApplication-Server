class Log
  prepData: (doc) ->
    _label = () ->
      temp = _.pluck(doc, 'created')
      _.forEach(temp, (s, index) ->
        temp[index] = moment(s).format("YYYY-MM-DD HH:mm")
      )
      return temp

    _data = () ->
      return _.pluck(doc, 'value')

    labels: _label()
    datasets: [ {
      fillColor: 'rgba(49, 195, 166, 0.2)'
      strokeColor: 'rgba(49, 195, 166, 1)'
      pointColor: 'rgba(49, 195, 166, 1)'
      pointStrokeColor: '#fff'
      data: _data()
    } ]
