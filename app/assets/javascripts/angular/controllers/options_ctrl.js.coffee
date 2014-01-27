App.controller 'OptionsCtrl', ['$scope', 'Option', ($scope, Option) ->
  $scope.options = []
  $scope.init = (project_id, instrument_id, question_id) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.question_id = question_id
    if instrument_id and question_id
      $scope.options = $scope.queryOptions()

  $scope.queryOptions = ->
    Option.query(
      {
        "project_id": $scope.project_id,
        "instrument_id": $scope.instrument_id,
        "question_id": $scope.question_id
      }
    )

  $scope.$on('SAVE_QUESTION', (event, id) ->
    if ($scope.question_id == id or !$scope.question_id)
      angular.forEach $scope.options, (option, index) ->
        $scope.question_id = id
        option.number_in_question = index + 1
        option.project_id = $scope.project_id
        option.instrument_id = $scope.instrument_id
        option.question_id = $scope.question_id
        if option.id
          option.$update()
        else
          option.$save()
      $scope.options = $scope.queryOptions()
  )

  $scope.$on('CANCEL_QUESTION', ->
    $scope.options = $scope.queryOptions()
  )

  $scope.removeOption = (option) ->
    $scope.options.splice($scope.options.indexOf(option), 1)
    option.project_id = $scope.project_id
    option.instrument_id = $scope.instrument_id
    option.question_id = $scope.question_id
    option.$delete()

  $scope.addOption = ->
    option = new Option
    option.project_id = $scope.project_id
    option.instrument_id = $scope.instrument_id
    option.question_id = $scope.question_id
    $scope.options.push(option)
]
