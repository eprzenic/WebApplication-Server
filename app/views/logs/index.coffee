class Log
  constructor: () ->

  data: (doc) ->
    tempD = doc
    _.forEach(tempD, (d, index) ->
        tempD[index].created = moment(d.created).format("HH")
    )

    tempL = _.pluck(tempD,'created');
    tempL = _.uniq(tempL)

    results = []

    _.forEach(tempL, (l, index) ->
      tempV = _.pluck(_.filter(tempD, 'created', l), 'value')
      tempA = _.sum(tempV) / tempV.length
      results.push( { created: l, value: Math.round(tempA) } )
    )

    return { 
      labels: _.pluck(results, 'created')
      datasets: [ {
        fillColor: 'rgba(49, 195, 166, 0.2)'
        strokeColor: 'rgba(49, 195, 166, 1)'
        pointColor: 'rgba(49, 195, 166, 1)'
        pointStrokeColor: '#fff'
        data: _.pluck(results, 'value')
      } ]
    }