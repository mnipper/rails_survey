App.factory 'Question', ['$resource', ($resource) ->
  $resource('/api/v1/frontend/projects/:project_id/instruments/:instrument_id/questions/:id?page=:page',
    {project_id: '@project_id', instrument_id: '@instrument_id', id: '@id', page: '@page'},
    {update: {method: 'PUT'}}
  )
]

App.factory 'CopyQuestion', ['$resource', ($resource) ->
  $resource('/api/v1/frontend/projects/:project_id/instruments/:instrument_id/questions/:id/copy',
    {project_id: '@project_id', instrument_id: '@instrument_id', id: '@id', copy_to: '@destination_instrument_id', q_id: '@copy_question_identifier', q_position: '@number_in_instrument'},
    {copy: {method: 'POST'}}
  )
]

