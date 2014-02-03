App.factory 'Graph', ['$resource', ($resource) ->
  $resource '/api/v1/graphs/daily_responses'
]