App.controller 'SectionTranslationsCtrl', ['$scope', 'SectionTranslation', ($scope, SectionTranslation) ->
  $scope.showOkButton = true
      
  $scope.init = (project_id, instrument_id, section_id, id, changed) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.section_id = section_id
    $scope.id = id
    $scope.section_translation_changed = changed
    
    $scope.setSectionChanged = (language, changed) ->
      translation = new SectionTranslation
      translation.language = language
      translation.section_changed = changed
      translation.project_id = $scope.project_id
      translation.instrument_id = $scope.instrument_id
      translation.section_id = $scope.section_id
      translation.id = $scope.id
      translation.$update({},
        (data) ->
          $scope.section_translation_changed = changed
          $scope.showOkButton = false
      )
]