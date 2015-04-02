App.controller 'GridsCtrl', ['$scope', 'Grid', ($scope, Grid) ->
  $scope.user = { name: 'awesome user' }  
  
  $scope.init = (project_id, instrument_id) ->
    $scope.project_id = project_id
    $scope.instrument_id = instrument_id
    $scope.displayNewTemplate = false
    $scope.gridQuestionTypes = ['SELECT_ONE', 'SELECT_MULTIPLE']
    $scope.grids = Grid.query({"project_id": project_id, "instrument_id": instrument_id})
  
  $scope.newGrid = ->
    $scope.displayNewTemplate = !$scope.displayNewTemplate
    $scope.grid = new Grid()
    $scope.grid.instrument_id = $scope.instrument_id
    $scope.grid.project_id = $scope.project_id
    $scope.grid.option_texts = []
    
  $scope.saveGrid = ->
    $scope.displayNewTemplate = false
    $scope.grid.$save({})
    
  $scope.addOptionLabel = ->
    $scope.grid.option_texts.push "new label"
    
  $scope.addOptionLabel = (grid) ->
    grid.option_texts ?= []
    grid.option_texts.push "new label"

  $scope.removeOptionLabel = (index) ->
    $scope.grid.option_texts.splice(index, 1)
  
  $scope.removeOptionLabel = (grid, index) ->
    grid.option_texts.splice(index, 1)
    $scope.updateGrid(grid)
    
  $scope.updateGrid = (grid) ->
    grid.project_id = $scope.project_id
    grid.$update({})
    
]
