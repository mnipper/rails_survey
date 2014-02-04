App.factory 'Graph', ['$resource', ($resource) ->
  $resource '/api/v1/projects/:project_id/graphs/', { project_id: '@project_id'}
]