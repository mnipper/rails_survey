App.controller 'FileUploadCtrl', ['$scope', '$fileUploader', 'Image', ($scope, $fileUploader, Image) ->
  $scope.images = []
  $scope.initialize = (project_id, instrument_id, question_id) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.question_id = question_id 
        
    if $scope.question_id   
      $scope.images = $scope.queryImages()
      
      uploader = $scope.uploader = $fileUploader.create({
        scope: $scope,
        url: '/api/v1/frontend/projects/' + $scope.project_id + '/instruments/' + $scope.instrument_id + '/questions/' + $scope.question_id + '/images/',
        headers: {'X-CSRF-Token': $('meta[name=csrf-token]').attr('content')},
        isHTML5: true,
        withCredentials: true,
        formData: [ { name: uploader } ]
      })
    
    if $scope.question_id
      uploader.filters.push (item) -> #{File|HTMLInputElement}
        type = (if uploader.isHTML5 then item.type else "/" + item.value.slice(item.value.lastIndexOf(".") + 1))
        type = "|" + type.toLowerCase().slice(type.lastIndexOf("/") + 1) + "|"
        "|jpg|png|jpeg|".indexOf(type) isnt -1
      
  $scope.queryImages = ->
    Image.query(
      {
        "project_id": $scope.project_id,
        "instrument_id": $scope.instrument_id,
        "question_id": $scope.question_id
      }, (result) ->
    )
   
  $scope.deleteImage = (image) ->
    image.project_id = $scope.project_id
    image.instrument_id = $scope.instrument_id
    image.question_id = $scope.question_id
    image.$delete()
    $scope.images.splice($scope.images.indexOf(image), 1)
    
  $scope.saveImageDetails = (image) ->
    image.project_id = $scope.project_id
    image.instrument_id = $scope.instrument_id
    image.question_id = $scope.question_id
    image.$update()
  
]
