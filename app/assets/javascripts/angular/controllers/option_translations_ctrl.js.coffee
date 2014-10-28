App.controller 'OptionTranslationsCtrl', ['$scope', 'OptionTranslation', ($scope, OptionTranslation) ->
  $scope.showOkButton = true
      
  $scope.init = (project_id, instrument_id, question_id, option_id, id, changed) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.question_id = question_id
    $scope.option_id = option_id
    $scope.id = id
    $scope.option_translation_changed = changed
    
    $scope.setOptionChanged = (language, changed) ->
      translation = new OptionTranslation
      translation.language = language
      translation.option_changed = changed
      translation.project_id = $scope.project_id
      translation.instrument_id = $scope.instrument_id
      translation.question_id = $scope.question_id
      translation.option_id = $scope.option_id
      translation.id = $scope.id
      translation.$update({},
        (data) ->
          $scope.option_translation_changed = changed
          $scope.showOkButton = false
      )
]