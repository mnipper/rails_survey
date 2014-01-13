App.factory 'Question', ['$resource', ($resource) ->
  $resource('/api/v1/instruments/:instrument_id/questions/:id',
    {instrument_id: '@instrument_id', id: '@id'},
    {update: {method: 'PUT'}}
  )
]
