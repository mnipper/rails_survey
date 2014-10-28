App.factory 'SectionTranslation', ['$resource', ($resource) ->
  $resource('/api/v1/frontend/projects/:project_id/instruments/:instrument_id/sections/:section_id/section_translations/:id',
    {project_id: '@project_id', instrument_id: '@instrument_id', section_id: '@section_id', id: '@id'},
    {update: {method: 'PUT'}}
  )
]