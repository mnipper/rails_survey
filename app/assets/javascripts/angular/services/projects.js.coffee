App.factory 'Project', ['$resource', ($resource) ->
  $resource '/api/v1/frontend/projects/:id', id: '@id'
]
