App.controller 'FileUploadCtrl', ['$scope', '$fileUploader', ($scope, $fileUploader) ->
  $scope.initialize = (project_id, instrument_id) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id

    uploader = $scope.uploader = $fileUploader.create({
      scope: $scope,
      url: 'new_image'
    })
    
    uploader.filters.push (item) -> #{File|HTMLInputElement}
      type = (if uploader.isHTML5 then item.type else "/" + item.value.slice(item.value.lastIndexOf(".") + 1))
      type = "|" + type.toLowerCase().slice(type.lastIndexOf("/") + 1) + "|"
      "|jpg|png|jpeg|bmp|gif|".indexOf(type) isnt -1
    
]
