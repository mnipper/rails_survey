App.controller 'QuestionTranslationsCtrl', ['$scope', 'QuestionTranslation', ($scope, QuestionTranslation) ->
  $scope.showOkButton = true
      
  $scope.init = (project_id, instrument_id, question_id, id, changed) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.question_id = question_id
    $scope.id = id
    $scope.question_translation_changed = changed
    
    $scope.setQuestionChanged = (language, changed) ->
      translation = new QuestionTranslation
      translation.language = language
      translation.question_changed = changed
      translation.project_id = $scope.project_id
      translation.instrument_id = $scope.instrument_id
      translation.question_id = $scope.question_id
      translation.id = $scope.id
      translation.$update({},
        (data) ->
          $scope.question_translation_changed = changed
          $scope.showOkButton = false
      )
]