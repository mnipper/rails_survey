App.controller 'OptionsCtrl', ['$scope', 'Option', ($scope, Option) ->
  $scope.options = []
  $scope.init = (project_id, instrument_id, question_id) ->
    $scope.project_id = project_id
    $scope.instrument_idx = instrument_id
    $scope.question_idx = question_id
    if instrument_id and question_id
      $scope.options = Option.query({"project_id": project_id, "instrument_id": instrument_id, "question_id": question_id})

  $scope.$on('SAVE_QUESTION', (event, id) ->
    if ($scope.question_idx == id or !$scope.question_idx)
      angular.forEach $scope.options, (option, index) ->
        $scope.question_idx = id
        option.instrument_id = $scope.instrument_idx
        option.question_id = $scope.question_idx
        if option.id
          option.$update()
        else
          option.$save()
      $scope.options = Option.query({"instrument_id": $scope.instrument_idx, "question_id": $scope.question_idx})
  )

  $scope.$on('CANCEL_QUESTION', ->
    $scope.options = Option.query({"instrument_id": $scope.instrument_idx, "question_id": $scope.question_idx})
  )

  $scope.removeOption = (option) ->
    $scope.options.splice($scope.options.indexOf(option), 1)
    option.instrument_id = $scope.instrument_idx
    option.question_id = $scope.question_idx
    option.$delete()

  $scope.addOption = ->
    option = new Option
    option.instrument_id = $scope.instrument_idx
    option.question_id = $scope.question_idx
    $scope.options.push(option)
]
