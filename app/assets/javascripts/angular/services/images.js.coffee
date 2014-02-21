App.factory 'Image', ['$resource', ($resource) ->
  $resource '/api/v1/frontend/projects/:project_id/images/:id', { project_id: '@project_id', id: '@id' }
]