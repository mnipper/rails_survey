App.controller 'GraphsCtrl', ['$scope', 'Graph', ($scope, Graph) ->
  #$scope.initialize = (project_id) ->
  #  $scope.project_id = project_id
  #  $scope.responses = Graph.query({"project_id": project_id})
  
  # Helper functions for generating new data
  #$scope.randomData = -> Math.round(Math.random() * 25)
  #$scope.t = -> new Date().getTime()
  
  # Maximum length of dataset
  #$scope.dataLength = 8

  # Populate initial data point
  #$scope.data = [{time: $scope.t(), data: $scope.randomData()}]
  
  # Adds a new random data point up to dataLength
  #$scope.updateData = ->
  #  $scope.data.push({time: $scope.t(), data: $scope.randomData()})
  #  if $scope.data.length > $scope.dataLength
  #    $scope.data.shift()
  $scope.data = [{time: "2014-01-31 00:00:00 UTC", data: 18}, {time: "2014-02-02 00:00:00 UTC", data: 6}, {time: "2014-02-03 00:00:00 UTC", data: 10}]
]