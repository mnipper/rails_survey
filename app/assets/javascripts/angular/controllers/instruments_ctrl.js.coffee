App.controller 'InstrumentsCtrl', ['$scope', 'Instrument', 'Question', ($scope, Instrument, Question) ->
  $scope.initialize = (project_id) ->
    $scope.project_id = project_id
    $scope.instruments = Instrument.query({"project_id": project_id})
]
