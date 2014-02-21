App.controller 'FileUploadCtrl', ['$scope', 'Image', '$upload', ($scope, Image, $upload) ->
  $scope.initialize = (project_id) ->
    $scope.project_id = project_id
    $scope.images = Image.query({"project_id": project_id})
  
  $scope.onFileSelect = ->
    
]
