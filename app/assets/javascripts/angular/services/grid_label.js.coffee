App.factory 'GridLabel', ['$resource', ($resource) ->
  $resource '/api/v1/frontend/projects/:project_id/instruments/:instrument_id/grids/:grid_id/grid_labels/:id', 
    { project_id: '@project_id', instrument_id: '@instrument_id', grid_id: '@grid_id', id: '@id' },
    {update: {method: 'PUT'}}
]