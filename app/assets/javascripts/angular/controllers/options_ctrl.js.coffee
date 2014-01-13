App.controller 'OptionsCtrl', ['$scope', 'Option', ($scope, Option) ->
  $scope.options = []
  $scope.init = (instrument_id, question_id) ->
    $scope.options = Option.query({"instrument_id": instrument_id, "question_id": question_id})

  $scope.removeOption = (option) ->
    $scope.options.splice($scope.options.indexOf(option), 1)

  $scope.addOption = ->
    $scope.options.push({})
]
