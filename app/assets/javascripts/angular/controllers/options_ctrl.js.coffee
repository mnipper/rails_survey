App.controller 'OptionsCtrl', ['$scope', 'Option', ($scope, Option) ->
  $scope.options = []
  $scope.init = (project_id, instrument_id, question_id) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.question_id = question_id
    if $scope.instrument_id and $scope.question_id
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
      $scope.question_id = id
      angular.forEach $scope.options, (option, index) ->
        option.number_in_question = index + 1
        option.project_id = $scope.project_id
        option.instrument_id = $scope.instrument_id
        option.question_id = $scope.question_id
        if option.id
          option.$update({},
            (data, headers) -> $scope.saveOptionSuccess(data, headers),
            (result, headers) -> alert "Error updating option"
          )
        else
          option.$save({},
            (data, headers) -> $scope.saveOptionSuccess(data, headers),
            (result, headers) -> alert "Error saving option"
          )
  )
  
  $scope.saveOptionSuccess = (data, headers) ->
    $scope.options = $scope.queryOptions()
    $scope.$broadcast('SAVE_OPTION', data.id)

  $scope.$on('CANCEL_QUESTION', ->
    $scope.options = $scope.queryOptions()
  )

  $scope.$on('EDIT_QUESTION', (event, id) ->
    if $scope.question_id == id
      $scope.options = $scope.queryOptions()
  )

  $scope.removeOption = (option) ->
    if confirm("Are you sure you want to delete this option?")
      $scope.options.splice($scope.options.indexOf(option), 1)
      option.project_id = $scope.project_id
      option.instrument_id = $scope.instrument_id
      option.question_id = $scope.question_id
      option.$delete({},
        (data, headers) -> $scope.options = $scope.queryOptions(),
        (result, headers) -> alert "Error deleting option"
      )

  $scope.addOption = ->
    option = new Option
    option.project_id = $scope.project_id
    option.instrument_id = $scope.instrument_id
    option.question_id = $scope.question_id
    $scope.options.push(option)
    
]
