App.factory 'Instrument', ['$resource', ($resource) ->
  $resource '/api/v1/instruments/:id', id: '@id'
]
