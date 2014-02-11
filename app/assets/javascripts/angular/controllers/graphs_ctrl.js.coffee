App.controller 'DailyGraphCtrl', ['$scope', 'DailyGraph', 'HourGraph', ($scope, DailyGraph, HourGraph) ->
  $scope.data = []
  $scope.lineData = []
  $scope.initialize = (project_id) ->
    $scope.project_id = project_id
    
    DailyGraph.query( {"project_id": project_id}, (result) ->
      hash = result[0]
      for k, v of hash
        if k[0] != '$'
          $scope.data.push {time:k , data:v}
    )
     
    HourGraph.query( {"project_id": project_id}, (result) ->
      array = []
      for key, value of result[0]  
        if key[0] != '$'
          hourCount = []
          hourCount.push parseInt(key, 10)
          hourCount.push value
          console.log hourCount 
          array.push hourCount 
      first = array[0..13]
      second = array[14..23]
      array = second.concat first
      console.log array
      console.log array.length
      $scope.lineData.push {"key": "hourly response count", "values": array }
    )
    
    
  #$scope.data = [{time: "2014-01-31 00:00:00 UTC", data: 18}, {time: "2014-02-02 00:00:00 UTC", data: 6}, {time: "2014-02-03 00:00:00 UTC", data: 10}]
  
]


