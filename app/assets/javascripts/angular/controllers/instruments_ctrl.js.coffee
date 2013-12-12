App.controller 'InstrumentsCtrl', ['$scope', 'Instrument', 'Question', ($scope, Instrument, Question) ->
  $scope.instruments = Instrument.query()
]
