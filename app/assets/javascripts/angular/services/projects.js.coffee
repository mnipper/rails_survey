App.factory 'Project', ['$resource', ($resource) ->
  $resource '/api/v1/projects/:id', id: '@id'
]