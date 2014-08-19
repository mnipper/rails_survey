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
    
]