App.factory 'Question', ['$resource', ($resource) ->
  $resource('/api/v1/frontend/projects/:project_id/instruments/:instrument_id/questions/:id?page=:page',
    {project_id: '@project_id', instrument_id: '@instrument_id', id: '@id', page: '@page'},
    {update: {method: 'PUT'}}
  )
]
