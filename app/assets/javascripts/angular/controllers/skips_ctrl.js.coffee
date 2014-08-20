App.controller 'SkipsCtrl', ['$scope', 'Skip', ($scope, Skip) ->
  $scope.skips = []
  $scope.init = (project_id, instrument_id, question_id, option_id) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.question_id = question_id
    $scope.option_id = option_id
    if $scope.option_id and $scope.question_id and $scope.instrument_id 
      $scope.skips = $scope.querySkips()

  $scope.querySkips = ->
    Skip.query(
      {
        "project_id": $scope.project_id,
        "instrument_id": $scope.instrument_id,
        "question_id": $scope.question_id,
        "option_id": $scope.option_id
      }
    )
    
  $scope.addQuestionToSkip = ->
    skip = new Skip
    skip.project_id = $scope.project_id
    skip.instrument_id = $scope.instrument_id
    skip.question_id = $scope.question_id
    skip.option_id = $scope.option_id
    $scope.skips.push(skip)
    
  $scope.$on('SAVE_OPTION', (event, id) ->
    if ($scope.option_id == id or !$scope.option_id)
      $scope.option_id = id
      angular.forEach $scope.skips, (skip, index) ->
        skip.project_id = $scope.project_id
        skip.instrument_id = $scope.instrument_id
        skip.question_id = $scope.question_id
        skip.option_id = $scope.option_id
        if skip.id
          skip.$update({},
            (data, headers) -> $scope.skips = $scope.querySkips(),
            (result, headers) -> alert "Error updating question to skip"
          )
        else
          skip.$save({},
            (data, headers) -> $scope.skips = $scope.querySkips(),
            (result, headers) -> alert "Error saving question to skip"
          )
  )
  
  $scope.removeSkip = (skip) ->
    if confirm("Are you sure you want to delete this question from those to skip?")
      $scope.skips.splice($scope.skips.indexOf(skip), 1)
      skip.project_id = $scope.project_id
      skip.instrument_id = $scope.instrument_id
      skip.question_id = $scope.question_id
      skip.option_id = $scope.option_id
      skip.$delete({},
        (data, headers) -> $scope.skips = $scope.querySkips(),
        (result, headers) -> alert "Error deleting question to skip"
      )
  
]