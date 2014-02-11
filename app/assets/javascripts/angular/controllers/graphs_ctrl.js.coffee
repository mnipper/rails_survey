App.controller 'DailyGraphCtrl', ['$scope', 'DailyGraph', 'HourGraph', ($scope, DailyGraph, HourGraph) ->
  $scope.dayData = []
  $scope.hourData = []
  $scope.initialize = (project_id) ->
    $scope.project_id = project_id
    $scope.fetchData()
    #setTimeout -> 
    #  $scope.fetchData()
    #, 60000
 
  $scope.fetchData = ->
    console.log "Called Called"
    DailyGraph.query( {"project_id": $scope.project_id}, (result) ->
      hash = result[0]
      for k, v of hash
        if k[0] != '$'
          $scope.dayData.push {time:k , data:v}
    )
        
    HourGraph.query( {"project_id": $scope.project_id}, (result) ->
      array = []
      for key, value of result[0]  
        if key[0] != '$'
          array.push {hour: key, data: value}
      first = array[0..13]
      second = array[14..23]
      $scope.hourData = second.concat first
    )
]


