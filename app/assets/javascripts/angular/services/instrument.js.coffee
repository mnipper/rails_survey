App.factory 'Instrument', ['$resource', ($resource) ->
  $resource '/api/v1/projects/:project_id/instruments/:id', { project_id: '@project_id', id: '@id' }
]
