App.controller 'GridQuestionsCtrl', ['$scope', 'Question', ($scope, Question) ->
  
  $scope.init = (project_id, instrument_id, grid_id) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.grid_id = grid_id
    $scope.getGridQuestions(project_id, instrument_id, grid_id)
    
  $scope.getGridQuestions = (project_id, instrument_id, grid_id) ->
    $scope.questions = Question.query({"project_id": project_id, "instrument_id": instrument_id, "grid_id": grid_id})
    
  $scope.$on('GRID_CHANGED', (event, id) ->
    $scope.getGridQuestions($scope.project_id, $scope.instrument_id, $scope.grid_id)
  )
  
  $scope.deleteQuestion = (question) ->
    if confirm("Are you sure you want to delete this question?")
      question.project_id = $scope.project_id
      question.instrument_id = $scope.instrument_id
      question.$delete({},
        (data) ->
          question.id = null
        ,
        (data) ->
          alert "Failed to delete question"
        )
      $scope.questions.splice($scope.questions.indexOf(question), 1)
  
  $scope.updateQuestion = (question) ->
    question.project_id = $scope.project_id
    question.instrument_id = $scope.instrument_id
    question.$update({})
    
]
