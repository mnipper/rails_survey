App.controller 'FileUploadCtrl', ['$scope', '$fileUploader', ($scope, $fileUploader) ->
  $scope.initialize = (project_id, instrument_id, question_id) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.question_id = question_id 
    
    if $scope.question_id    
      uploader = $scope.uploader = $fileUploader.create({
        scope: $scope,
        url: '/api/v1/frontend/projects/' + $scope.project_id + '/instruments/' + $scope.instrument_id + '/questions/' + $scope.question_id + '/images/'
      })
    
    uploader.filters.push (item) -> #{File|HTMLInputElement}
      type = (if uploader.isHTML5 then item.type else "/" + item.value.slice(item.value.lastIndexOf(".") + 1))
      type = "|" + type.toLowerCase().slice(type.lastIndexOf("/") + 1) + "|"
      "|jpg|png|jpeg|bmp|gif|".indexOf(type) isnt -1
    
]
