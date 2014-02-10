App.factory 'Instrument', ['$resource', ($resource) ->
  $resource '/api/v1/frontend/projects/:project_id/instruments/:id', { project_id: '@project_id', id: '@id' }
]
