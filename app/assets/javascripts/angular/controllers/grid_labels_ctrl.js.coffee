App.controller 'GridLabelsCtrl', ['$scope', 'GridLabel', ($scope, GridLabel) ->
  
  $scope.init = (project_id, instrument_id, grid_id) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.grid_id = grid_id
    if grid_id
      $scope.queryGridLabels(project_id, instrument_id, grid_id)
    
  $scope.queryGridLabels = (project_id, instrument_id, grid_id) ->
    $scope.grid_labels = GridLabel.query({"project_id": project_id, "instrument_id": instrument_id, "grid_id": grid_id})
    
  $scope.addGridLabel = (grid) ->
    grid_label = new GridLabel()
    grid_label.project_id = $scope.project_id
    grid_label.instrument_id = $scope.instrument_id
    grid_label.grid_id = $scope.grid_id
    grid_label.text = "new label"
    $scope.grid_labels ?= []
    $scope.grid_labels.push(grid_label)
    
  $scope.removeGridLabel = (grid_label) ->
    grid_label.$delete({},
      (data) ->
        $scope.grid_labels.splice($scope.grid_labels.indexOf(grid_label), 1)
      ,
      (data) ->
        alert "Failed to delete grid label"
      )
  
  $scope.$on('GRID_SAVED', (event, id) ->
    angular.forEach $scope.grid_labels, (label, index) ->
      if not label.id?
        label.project_id = $scope.project_id
        label.instrument_id = $scope.instrument_id
        label.grid_id = id
        label.$save({},
          (data, headers) -> ,
          (result, headers) -> alert "Error saving grid label"
        )
  )
  
  $scope.saveLabel = (label) ->
    label.project_id = $scope.project_id
    label.instrument_id = $scope.instrument_id
    if label.id
      label.$update({},
        (data, headers) -> ,
        (result, headers) -> alert "Error updating grid label"
      )
    else
      label.$save({},
        (data, headers) -> ,
        (result, headers) -> alert "Error saving grid label"
      )
      
]
