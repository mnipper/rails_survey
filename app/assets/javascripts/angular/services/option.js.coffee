App.factory 'Option', ['$resource', ($resource) ->
  $resource('/api/v1/instruments/:instrument_id/questions/:question_id/options/:id',
    {instrument_id: '@instrument_id', question_id: '@question_id', id: '@id'},
    {update: {method: 'PUT'}}
  )
]
